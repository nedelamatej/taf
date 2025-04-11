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
   * @brief Scene component
   *
   * @author Matej Nedela
   */

  import { CubicBezierCurve3, Vector3 } from 'three';
  import Camera from './Camera.svelte';
  import Pitch from './Pitch.svelte';
  import StrikeZone from './StrikeZone.svelte';
  import Field from './Field.svelte';
  import { untrack } from 'svelte';

  /**
   * @typedef {Object} Props
   *
   * @property {any} data
   * @property {boolean} [pin1]
   * @property {boolean} [pin2]
   * @property {boolean} [strikeZone]
   * @property {Camera} camera
   */

  /** @type {Props} */
  let { data, pin1 = false, pin2 = false, strikeZone = true, camera = $bindable() } = $props();

  const OUTFIELD_DISTANCE = 76.2;
  const PITCHING_DISTANCE = 14.02;

  /**
   * @brief Gets the cubic Bezier curve for the pitch data
   *
   * @return {CubicBezierCurve3} - cubic Bezier curve
   */
  function getPitchCurve() {
    return new CubicBezierCurve3(...[0, 1, 2, 3].map((i) => new Vector3(...data[`xyz_${i}`])));
  }

  let pitch0 = $derived(getPitchCurve());
  let pitch1 = $derived(pin1 ? untrack(getPitchCurve) : undefined);
  let pitch2 = $derived(pin2 ? untrack(getPitchCurve) : undefined);
</script>

<Camera bind:this={camera} {PITCHING_DISTANCE} />

{#if pitch0}
  <Pitch pitch={pitch0} color="red" />
{/if}

{#if pitch1}
  <Pitch pitch={pitch1} color="green" />
{/if}

{#if pitch2}
  <Pitch pitch={pitch2} color="blue" />
{/if}

{#if strikeZone}
  <StrikeZone />
{/if}

<Field {OUTFIELD_DISTANCE} {PITCHING_DISTANCE} {pitch0} {pitch1} {pitch2} />
