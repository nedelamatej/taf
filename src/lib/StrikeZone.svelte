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
   * @brief Strike zone component
   *
   * @author Matej Nedela
   */

  import { T } from '@threlte/core';
  import { DoubleSide } from 'three';
</script>

<T.Mesh position={[0.432, 0.78, 0]} rotation.y={-Math.PI / 2}>
  <T.PlaneGeometry args={[0.432, 0.64]} />

  <T.ShaderMaterial
    vertexShader="void main() &lcub; gl_Position = projectionMatrix * modelViewMatrix * vec4(position, 1.0); &rcub;"
    fragmentShader="void main() &lcub; gl_FragColor = vec4(0.98, 0.66, 0.15, 0.33); &rcub;"
    side={DoubleSide}
    transparent={true}
  />
</T.Mesh>
