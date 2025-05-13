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
  import Input from '$lib/common/Input.svelte';
  import PitchBox from '$lib/components/PitchBox.svelte';
  import ValueBox from '$lib/components/ValueBox.svelte';
  import Scene from '$lib/Scene.svelte';
  import ButtonLink from '$lib/common/ButtonLink.svelte';
  import Button from '$lib/common/Button.svelte';
  import { untrack } from 'svelte';
  import { browser } from '$app/environment';
  import { page } from '$app/state';
  import { onMount } from 'svelte';

  let captions = $state();

  onMount(async () => {
    if (data.pitch.idx === 1) {
      document.getElementsByTagName('div')[0].classList.add('!hidden');

      await new Promise((resolve) => setTimeout(resolve, 1000));

      document.getElementsByTagName('div')[0].classList.remove('!hidden');

      captions = undefined;
      camera.setVideoInitialView();

      await new Promise((resolve) => setTimeout(resolve, 3000));

      // left handed batter view
      captions = 'Přednastavený pohled pravorukého pálkaře';
      document
        .getElementsByTagName('button')[4]
        .classList.add('!ring-2', '!ring-inset', '!ring-blue-800');

      await new Promise((resolve) => setTimeout(resolve, 500));

      document.getElementsByTagName('button')[4].click();

      await new Promise((resolve) => setTimeout(resolve, 500));

      document
        .getElementsByTagName('button')[4]
        .classList.remove('!ring-2', '!ring-inset', '!ring-blue-800');

      await new Promise((resolve) => setTimeout(resolve, 3000));

      // right handed batter view
      captions = 'Přednastavený pohled levorukého pálkaře';
      document
        .getElementsByTagName('button')[5]
        .classList.add('!ring-2', '!ring-inset', '!ring-blue-800');

      await new Promise((resolve) => setTimeout(resolve, 500));

      document.getElementsByTagName('button')[5].click();

      await new Promise((resolve) => setTimeout(resolve, 500));

      document
        .getElementsByTagName('button')[5]
        .classList.remove('!ring-2', '!ring-inset', '!ring-blue-800');

      await new Promise((resolve) => setTimeout(resolve, 3000));

      // pitcher view
      captions = 'Přednastavený pohled nadhazovače';
      document
        .getElementsByTagName('button')[6]
        .classList.add('!ring-2', '!ring-inset', '!ring-blue-800');

      await new Promise((resolve) => setTimeout(resolve, 500));

      document.getElementsByTagName('button')[6].click();

      await new Promise((resolve) => setTimeout(resolve, 500));

      document
        .getElementsByTagName('button')[6]
        .classList.remove('!ring-2', '!ring-inset', '!ring-blue-800');

      await new Promise((resolve) => setTimeout(resolve, 3000));

      // catcher view
      captions = 'Přednastavený pohled chytače';
      document
        .getElementsByTagName('button')[7]
        .classList.add('!ring-2', '!ring-inset', '!ring-blue-800');

      await new Promise((resolve) => setTimeout(resolve, 500));

      document.getElementsByTagName('button')[7].click();

      await new Promise((resolve) => setTimeout(resolve, 500));

      document
        .getElementsByTagName('button')[7]
        .classList.remove('!ring-2', '!ring-inset', '!ring-blue-800');

      await new Promise((resolve) => setTimeout(resolve, 3000));

      // side view
      captions = 'Přednastavený boční pohled';
      document
        .getElementsByTagName('button')[8]
        .classList.add('!ring-2', '!ring-inset', '!ring-blue-800');

      await new Promise((resolve) => setTimeout(resolve, 500));

      document.getElementsByTagName('button')[8].click();

      await new Promise((resolve) => setTimeout(resolve, 500));

      document
        .getElementsByTagName('button')[8]
        .classList.remove('!ring-2', '!ring-inset', '!ring-blue-800');

      await new Promise((resolve) => setTimeout(resolve, 3000));

      // top view
      captions = 'Přednastavený horní pohled';
      document
        .getElementsByTagName('button')[9]
        .classList.add('!ring-2', '!ring-inset', '!ring-blue-800');

      await new Promise((resolve) => setTimeout(resolve, 500));

      document.getElementsByTagName('button')[9].click();

      await new Promise((resolve) => setTimeout(resolve, 500));

      document
        .getElementsByTagName('button')[9]
        .classList.remove('!ring-2', '!ring-inset', '!ring-blue-800');

      await new Promise((resolve) => setTimeout(resolve, 3000));

      // default view
      captions = 'Výchozí pohled kamery';
      document
        .getElementsByTagName('button')[5]
        .classList.add('!ring-2', '!ring-inset', '!ring-blue-800');

      await new Promise((resolve) => setTimeout(resolve, 500));

      document.getElementsByTagName('button')[5].click();

      await new Promise((resolve) => setTimeout(resolve, 500));

      document
        .getElementsByTagName('button')[5]
        .classList.remove('!ring-2', '!ring-inset', '!ring-blue-800');

      await new Promise((resolve) => setTimeout(resolve, 3000));

      // move forward
      captions = 'Posun o nadhoz vpřed';
      document
        .getElementsByTagName('a')[2]
        .classList.add('!ring-2', '!ring-inset', '!ring-blue-800');

      await new Promise((resolve) => setTimeout(resolve, 500));

      document.getElementsByTagName('a')[2].click();

      await new Promise((resolve) => setTimeout(resolve, 500));

      document
        .getElementsByTagName('a')[2]
        .classList.remove('!ring-2', '!ring-inset', '!ring-blue-800');

      await new Promise((resolve) => setTimeout(resolve, 3000));

      // move backward
      captions = 'Posun o nadhoz vzad';
      document
        .getElementsByTagName('a')[1]
        .classList.add('!ring-2', '!ring-inset', '!ring-blue-800');

      await new Promise((resolve) => setTimeout(resolve, 500));

      document.getElementsByTagName('a')[1].click();

      await new Promise((resolve) => setTimeout(resolve, 500));

      document
        .getElementsByTagName('a')[1]
        .classList.remove('!ring-2', '!ring-inset', '!ring-blue-800');

      await new Promise((resolve) => setTimeout(resolve, 3000));

      // jump to 10th pitch
      captions = 'Přeskočení na 10. nadhoz';
      document
        .getElementsByTagName('input')[0]
        .classList.add('!ring-2', '!ring-inset', '!ring-blue-800');

      await new Promise((resolve) => setTimeout(resolve, 500));

      jumpTo = 1;

      await new Promise((resolve) => setTimeout(resolve, 500));

      jumpTo = 10;

      await new Promise((resolve) => setTimeout(resolve, 500));

      document.getElementsByTagName('input')[0].form?.submit();
    } else if (data.pitch.idx === 10) {
      await new Promise((resolve) => setTimeout(resolve, 3000));

      // hide strikezone
      captions = 'Skrytí strikezóny';
      document
        .getElementsByTagName('button')[1]
        .classList.add('!ring-2', '!ring-inset', '!ring-blue-800');

      await new Promise((resolve) => setTimeout(resolve, 500));

      document.getElementsByTagName('button')[1].click();

      await new Promise((resolve) => setTimeout(resolve, 500));

      document
        .getElementsByTagName('button')[1]
        .classList.remove('!ring-2', '!ring-inset', '!ring-blue-800');

      await new Promise((resolve) => setTimeout(resolve, 3000));

      // show strikezone
      captions = 'Zobrazení strikezóny';
      document
        .getElementsByTagName('button')[1]
        .classList.add('!ring-2', '!ring-inset', '!ring-blue-800');

      await new Promise((resolve) => setTimeout(resolve, 500));

      document.getElementsByTagName('button')[1].click();

      await new Promise((resolve) => setTimeout(resolve, 500));

      document
        .getElementsByTagName('button')[1]
        .classList.remove('!ring-2', '!ring-inset', '!ring-blue-800');

      await new Promise((resolve) => setTimeout(resolve, 3000));

      // pin current pitch
      captions = 'Připnutí aktuálního nadhozu';
      document
        .getElementsByTagName('button')[2]
        .classList.add('!ring-2', '!ring-inset', '!ring-blue-800');

      await new Promise((resolve) => setTimeout(resolve, 500));

      document.getElementsByTagName('button')[2].click();

      await new Promise((resolve) => setTimeout(resolve, 500));

      document
        .getElementsByTagName('button')[2]
        .classList.remove('!ring-2', '!ring-inset', '!ring-blue-800');

      await new Promise((resolve) => setTimeout(resolve, 3000));

      // move to 13th pitch
      captions = 'Posun na 13. nadhoz';
      document
        .getElementsByTagName('a')[4]
        .classList.add('!outline-2', '!outline-offset-2', '!outline-blue-800');

      await new Promise((resolve) => setTimeout(resolve, 500));

      document.getElementsByTagName('a')[4].click();

      await new Promise((resolve) => setTimeout(resolve, 500));

      document
        .getElementsByTagName('a')[4]
        .classList.remove('!outline-2', '!outline-offset-2', '!outline-blue-800');

      await new Promise((resolve) => setTimeout(resolve, 500));

      document
        .getElementsByTagName('a')[4]
        .classList.add('!outline-2', '!outline-offset-2', '!outline-blue-800');

      await new Promise((resolve) => setTimeout(resolve, 500));

      document.getElementsByTagName('a')[4].click();

      await new Promise((resolve) => setTimeout(resolve, 500));

      document
        .getElementsByTagName('a')[4]
        .classList.remove('!outline-2', '!outline-offset-2', '!outline-blue-800');

      await new Promise((resolve) => setTimeout(resolve, 500));

      document
        .getElementsByTagName('a')[4]
        .classList.add('!outline-2', '!outline-offset-2', '!outline-blue-800');

      await new Promise((resolve) => setTimeout(resolve, 500));

      document.getElementsByTagName('a')[4].click();

      await new Promise((resolve) => setTimeout(resolve, 500));

      document
        .getElementsByTagName('a')[4]
        .classList.remove('!outline-2', '!outline-offset-2', '!outline-blue-800');

      await new Promise((resolve) => setTimeout(resolve, 3000));

      // pin current pitch
      captions = 'Označení nadhozu typem "changeup"';
      document
        .getElementsByTagName('button')[13]
        .classList.add('!outline-2', '!outline-offset-2', '!outline-blue-800');

      await new Promise((resolve) => setTimeout(resolve, 500));

      document.getElementsByTagName('button')[13].click();

      await new Promise((resolve) => setTimeout(resolve, 500));

      document
        .getElementsByTagName('button')[13]
        .classList.remove('!outline-2', '!outline-offset-2', '!outline-blue-800');

      await new Promise((resolve) => setTimeout(resolve, 3000));

      captions = undefined;
      camera.setSideView();
    }
  });

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
  let jumpTo = $derived.by(() => {
    return page.params.idx, undefined;
  });
</script>

<svelte:head>
  <title>Tranim App | Pitch</title>
</svelte:head>

<div class="h-[810px] w-screen">
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
            if (!browser) return;

            navigator.clipboard.writeText(window.location.href);

            copied = true;

            setTimeout(() => (copied = false), 2000);
          }}
          tooltip={copied ? 'Copied!' : 'Copy link to clipboard'}
          shortcut={copied ? undefined : 'mod+c'}
        />
      </div>

      <div class="w-34"></div>

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

      <div class="w-34">
        <form action={`/pitch/${page.params.eventId}/${page.params.pitcherId}/${jumpTo}`}>
          <Input
            bind:value={jumpTo}
            type="number"
            placeholder="Jump to..."
            shortcut="j"
            min={1}
            max={pitch.cnt}
          />
        </form>
      </div>

      <div class="flex w-34 gap-2">
        <IconButton
          icon="fa-regular fa-expand"
          onclick={() => (strikeZone = !strikeZone)}
          tooltip={strikeZone ? 'Hide strike zone' : 'Show strike zone'}
          shortcut="z"
        />

        <IconButton
          icon="fa-solid {pin1 ? 'fa-thumbtack-slash' : 'fa-thumbtack'}"
          smallIcon="fa-solid fa-1"
          onclick={() => (pin1 = !pin1)}
          tooltip={pin1 ? 'Unpin from 1st position' : 'Pin to 1st position'}
          shortcut="1"
        />

        <IconButton
          icon="fa-solid {pin2 ? 'fa-thumbtack-slash' : 'fa-thumbtack'}"
          smallIcon="fa-solid fa-2"
          onclick={() => (pin2 = !pin2)}
          tooltip={pin2 ? 'Unpin from 2nd position' : 'Pin to 2nd position'}
          shortcut="2"
        />
      </div>
    </div>
  </div>

  <div class="relative h-[694px]">
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
          value={getTilt(pitch.alpha - Math.PI / 2)}
          value1={pitch1 ? getTilt(pitch1.alpha - Math.PI / 2) : undefined}
          value2={pitch2 ? getTilt(pitch2.alpha - Math.PI / 2) : undefined}
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

    {#if captions}
      <div class="absolute top-53 left-0 flex w-full justify-center">
        <div class="bg-blue-200/42 px-3 py-1.5 text-xl font-medium text-blue-800">
          {captions}
        </div>
      </div>
    {/if}

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
