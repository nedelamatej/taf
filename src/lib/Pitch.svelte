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
   * @brief Pitch component
   *
   * @author Matej Nedela
   */

  import { T, extend } from '@threlte/core';
  import { Color, SRGBColorSpace } from 'three';
  import { Line2 } from 'three/addons/lines/Line2.js';
  import { LineMaterial } from 'three/addons/lines/LineMaterial.js';
  import { LineGeometry } from 'three/addons/lines/LineGeometry.js';

  extend({ Line2, LineMaterial });

  /**
   * @typedef {Object} Props
   *
   * @property {any} [pitch]
   * @property {'red' | 'green' | 'blue'} [color]
   */

  /** @type {Props} */
  let { pitch = undefined, color } = $props();

  let lineGeometry = $derived(new LineGeometry().setFromPoints(pitch.getPoints(20)));
</script>

<T.Line2>
  <T is={lineGeometry} />

  {#if color === 'red'}
    <T.LineMaterial
      color={new Color().setRGB(0.78, 0.16, 0.16, SRGBColorSpace)}
      linewidth={0.1}
      worldUnits={true}
      toneMapped={false}
    />
  {:else if color === 'green'}
    <T.LineMaterial
      color={new Color().setRGB(0.18, 0.49, 0.2, SRGBColorSpace)}
      linewidth={0.1}
      worldUnits={true}
      toneMapped={false}
    />
  {:else if color === 'blue'}
    <T.LineMaterial
      color={new Color().setRGB(0.08, 0.4, 0.75, SRGBColorSpace)}
      linewidth={0.1}
      worldUnits={true}
      toneMapped={false}
    />
  {/if}
</T.Line2>
