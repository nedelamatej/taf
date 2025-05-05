<script>
  /*
   * Bakalarska prace
   * MODELOVANI A ANALYZA TRAJEKTORII SOFTBALLOVEHO NADHOZU
   *
   * Vysoke uceni technicke v Brne
   * Fakulta informacnich technologii
   * Ustav pocitacove grafiky a multimedii
   *
   * Autor:   Matej Nedela
   * Vedouci: Ing. Tomas Milet, Ph.D.
   */

  /**
   * @file
   * @brief Pitch page
   *
   * @author Matej Nedela
   */

  import { Canvas } from '@threlte/core';
  import IconButtonLink from '$lib/common/IconButtonLink.svelte';
  import IconButton from '$lib/common/IconButton.svelte';
  import PitchBox from '$lib/components/PitchBox.svelte';
  import ValueBox from '$lib/components/ValueBox.svelte';
  import Scene from '$lib/Scene.svelte';
  import ButtonLink from '$lib/common/ButtonLink.svelte';
  import Button from '$lib/common/Button.svelte';
  import { untrack } from 'svelte';
  import { page } from '$app/state';

  let { data } = $props();

  let pitch = $derived(data.pitch);
  let pitchType = $derived(pitch.type);

  let pin1 = $state(false);
  let pin2 = $state(false);
  let strikeZone = $state(true);

  let pitch1 = $derived(pin1 ? untrack(() => pitch) : null);
  let pitch2 = $derived(pin2 ? untrack(() => pitch) : null);

  let camera = $state();

  /**
   * @brief Gets velocity in kilometers per hour
   *
   * @param {number} v - velocity in meters per second
   *
   * @return {string} velocity in kilometers per hour
   */
  function getVelocity(v) {
    return (v * 3.6).toFixed(1);
  }

  /**
   * @brief Gets rotation count
   *
   * @param {number} omega - angular velocity in radians per second
   * @param {number} t - flight duration in seconds
   *
   * @return {string} rotation count
   */
  function getCount(omega, t) {
    return ((omega / (2 * Math.PI)) * t).toFixed(2);
  }

  /**
   * @brief Gets rotation tilt in hours and minutes
   *
   * @param {number} alpha - rotation angle in radians
   *
   * @return {string} rotation tilt in hours and minutes
   */
  function getTilt(alpha) {
    let time = Math.round((((alpha / (2 * Math.PI)) * 12) % 12) * 4) / 4 || 12;

    return `${Math.floor(time)}:${Math.round((time % 1) * 60) || '00'}`;
  }

  /**
   * @brief Gets angle in degrees
   *
   * @param {number} angle - angle in radians
   *
   * @return {string} angle in degrees
   */
  function getAngle(angle) {
    return Math.abs((angle * 180) / Math.PI).toFixed(0);
  }

  let copied = $state(false);
</script>

<div class="h-screen w-screen">
  <div class="h-1 bg-orange-50">
    <div class="h-1 bg-orange-500" style="width: {(pitch.idx / pitch.cnt) * 100}%;"></div>
  </div>

  <div class="bg-orange-50 px-3 py-2">
    <div class="mx-auto flex max-w-[1440px] justify-between">
      <div class="flex w-34 gap-2">
        <IconButtonLink icon="fa-solid fa-house" href="/" tooltip="Home" />

        <IconButton
          icon={copied ? 'fa-solid fa-check' : 'fa-solid fa-link'}
          onclick={async () => {
            navigator.clipboard.writeText(window.location.href);

            copied = true;

            setTimeout(() => (copied = false), 2000);
          }}
          tooltip={copied ? 'Copied!' : 'Copy link to clipboard'}
          shortcut={copied ? undefined : 'mod+c'}
        />
      </div>

      <div class="flex items-center gap-2">
        {#key pitch.idx}
          <IconButtonLink
            icon="fa-solid fa-chevron-left"
            href={`/pitch/${page.params.eventId}/${page.params.pitcherId}/${Number(page.params.idx) - 1}`}
            tooltip="Previous pitch"
            shortcut="left"
            disabled={pitch.idx === 1}
          />
        {/key}

        <span class="tabular-nums">
          {String(pitch.idx).padStart(3, '0')} / {String(pitch.cnt).padStart(3, '0')}
        </span>

        {#key pitch.idx}
          <IconButtonLink
            icon="fa-solid fa-chevron-right"
            href={`/pitch/${page.params.eventId}/${page.params.pitcherId}/${Number(page.params.idx) + 1}`}
            tooltip="Next pitch"
            shortcut="right"
            disabled={pitch.idx === pitch.cnt}
          />
        {/key}
      </div>

      <div class="flex w-34 gap-2">
        <IconButton
          icon="fa-regular fa-expand"
          onclick={() => (strikeZone = !strikeZone)}
          tooltip="Show strike zone"
          shortcut="z"
        />

        <IconButton
          icon="fa-solid {pin1 ? 'fa-thumbtack-slash' : 'fa-thumbtack'}"
          smallIcon="fa-solid fa-1"
          onclick={() => (pin1 = !pin1)}
          tooltip="Pin to 1st position"
          shortcut="1"
        />

        <IconButton
          icon="fa-solid {pin2 ? 'fa-thumbtack-slash' : 'fa-thumbtack'}"
          smallIcon="fa-solid fa-2"
          onclick={() => (pin2 = !pin2)}
          tooltip="Pin to 2nd position"
          shortcut="2"
        />
      </div>
    </div>
  </div>

  <div class="relative h-[calc(100vh-116px)]">
    <Canvas>
      <Scene bind:camera data0={pitch} data1={pitch1} data2={pitch2} {strikeZone} />
    </Canvas>

    <div class="absolute top-0 left-0 w-full p-3">
      <div class="mx-auto flex h-53 max-w-[1440px] flex-col flex-wrap gap-3">
        <PitchBox {pitch} {pitch1} {pitch2} />

        <ValueBox
          label="Initial velocity [km/h]"
          value={getVelocity(pitch.v_0)}
          value1={pitch1 ? getVelocity(pitch1.v_0) : undefined}
          value2={pitch2 ? getVelocity(pitch2.v_0) : undefined}
        />

        <ValueBox
          label="Final velocity [km/h]"
          value={getVelocity(pitch.v_t)}
          value1={pitch1 ? getVelocity(pitch1.v_t) : undefined}
          value2={pitch2 ? getVelocity(pitch2.v_t) : undefined}
        />

        <ValueBox
          label="Rotation count"
          value={getCount(pitch.omega, pitch.t)}
          value1={pitch1 ? getCount(pitch1.omega, pitch1.t) : undefined}
          value2={pitch2 ? getCount(pitch2.omega, pitch2.t) : undefined}
        />

        <ValueBox
          label="Rotation tilt"
          value={getTilt(pitch.alpha)}
          value1={pitch1 ? getTilt(pitch1.alpha) : undefined}
          value2={pitch2 ? getTilt(pitch2.alpha) : undefined}
        />

        <ValueBox
          label="Horizontal angle [deg]"
          value={`${getAngle(pitch.phi_0 - Math.PI / 2)}&deg; ${pitch.phi_0 > Math.PI / 2 ? 'R' : 'L'}`}
          value1={pitch1
            ? `${getAngle(pitch1.phi_0 - Math.PI / 2)}&deg; ${pitch1.phi_0 > Math.PI / 2 ? 'R' : 'L'}`
            : undefined}
          value2={pitch2
            ? `${getAngle(pitch2.phi_0 - Math.PI / 2)}&deg; ${pitch2.phi_0 > Math.PI / 2 ? 'R' : 'L'}`
            : undefined}
        />

        <ValueBox
          label="Vertical angle [deg]"
          value={`${getAngle(Math.PI - pitch.theta_0)}&deg; ${pitch.theta_0 < Math.PI ? 'U' : 'D'}`}
          value1={pitch1
            ? `${getAngle(Math.PI - pitch1.theta_0)}&deg; ${pitch1.theta_0 < Math.PI ? 'U' : 'D'}`
            : undefined}
          value2={pitch2
            ? `${getAngle(Math.PI - pitch2.theta_0)}&deg; ${pitch2.theta_0 < Math.PI ? 'U' : 'D'}`
            : undefined}
        />
      </div>
    </div>

    <div class="absolute right-0 bottom-0 flex w-28 flex-wrap gap-2 px-3 py-2">
      <IconButton
        icon="fa-solid fa-baseball-bat-ball"
        smallIcon="fa-solid fa-r"
        onclick={() => camera.setRightHandedBatterView()}
        tooltip="Right handed batter view"
        shortcut="r"
      />

      <IconButton
        icon="fa-solid fa-baseball-bat-ball"
        smallIcon="fa-solid fa-l"
        onclick={() => camera.setLeftHandedBatterView()}
        tooltip="Left handed batter view"
        shortcut="l"
      />

      <IconButton
        icon="fa-solid fa-baseball"
        onclick={() => camera.setPitcherView()}
        tooltip="Pitcher view"
        shortcut="p"
      />

      <IconButton
        icon="fa-solid fa-hand-back-fist"
        onclick={() => camera.setCatcherView()}
        tooltip="Catcher view"
        shortcut="c"
      />

      <IconButton
        icon="fa-solid fa-angles-left"
        onclick={() => camera.setSideView()}
        tooltip="Side view"
        shortcut="s"
      />

      <IconButton
        icon="fa-solid fa-angles-down"
        onclick={() => camera.setTopView()}
        tooltip="Top view"
        shortcut="t"
      />
    </div>
  </div>

  <div class="bg-orange-50 px-3 py-2">
    <div class="mx-auto flex max-w-[1440px] justify-between">
      <ButtonLink
        secondary
        value="Previous"
        href={`/pitch/${page.params.eventId}/${page.params.pitcherId}/${Number(page.params.idx) - 1}`}
        disabled={pitch.idx === 1}
        cssClass="!w-22"
      />

      <div class="flex gap-2">
        {#each data.types as type, idx (type.id)}
          <Button
            primary={pitchType === type.id}
            secondary={pitchType !== type.id}
            value={type.name}
            onclick={async () => {
              pitchType = pitchType !== type.id ? type.id : null;

              await fetch(`https://tranim.nede.cz/api/pitch/${pitch.id}`, {
                method: 'PUT',
                body: JSON.stringify({ type: pitchType })
              });
            }}
            shortcut={String((idx + 3) % 10)}
            justifyContent="start"
            cssClass="!w-34"
          />
        {/each}
      </div>

      <ButtonLink
        secondary
        value="Next"
        href={`/pitch/${page.params.eventId}/${page.params.pitcherId}/${Number(page.params.idx) + 1}`}
        disabled={pitch.idx === pitch.cnt}
        cssClass="!w-22"
      />
    </div>
  </div>
</div>
