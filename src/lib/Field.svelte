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
   * @brief Field component
   *
   * @author Matej Nedela
   */

  import { T } from '@threlte/core';
  import vertexShader from './shaders/vertex.glsl?raw';
  import fragmentShader from './shaders/fragment.glsl?raw';

  let { pitch } = $props();

  const OUTFIELD_DISTANCE = 76.2;
  const PITCHING_DISTANCE = 14.02;
</script>

<T.Mesh
  position={[(OUTFIELD_DISTANCE - 8.23) / Math.sqrt(2), 0, 0]}
  rotation.x={-Math.PI / 2}
  rotation.z={-Math.PI / 4}
>
  <T.PlaneGeometry args={[OUTFIELD_DISTANCE + 8.23, OUTFIELD_DISTANCE + 8.23]} />
  <T.ShaderMaterial
    {vertexShader}
    {fragmentShader}
    uniforms={{
      OUTFIELD_DISTANCE: { value: OUTFIELD_DISTANCE },
      PITCHING_DISTANCE: { value: PITCHING_DISTANCE },
      pitch: { value: 0 }
    }}
    uniforms.pitch.value={pitch}
  />
</T.Mesh>
