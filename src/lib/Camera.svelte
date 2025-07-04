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
   * @brief Camera component
   *
   * @author Matej Nedela
   */

  import { T, useTask, useThrelte } from '@threlte/core';
  import CameraControls from 'camera-controls';
  import {
    Box3,
    Matrix4,
    PerspectiveCamera,
    Quaternion,
    Raycaster,
    Sphere,
    Spherical,
    Vector2,
    Vector3,
    Vector4
  } from 'three';

  CameraControls.install({
    THREE: {
      Box3,
      Matrix4,
      Quaternion,
      Raycaster,
      Sphere,
      Spherical,
      Vector2,
      Vector3,
      Vector4
    }
  });

  /**
   * @typedef {Object} Props
   *
   * @property {number} PITCHING_DISTANCE
   */

  /** @type {Props} */
  let { PITCHING_DISTANCE } = $props();

  /**
   * @brief Sets the camera position for the right-handed batter view
   */
  export function setRightHandedBatterView() {
    controls.setPosition(-1.5, 1.5, -0.75, true);
  }

  /**
   * @brief Sets the camera position for the left-handed batter view
   */
  export function setLeftHandedBatterView() {
    controls.setPosition(-1.5, 1.5, 0.75, true);
  }

  /**
   * @brief Sets the camera position for the pitcher view
   */
  export function setPitcherView() {
    controls.setPosition(PITCHING_DISTANCE, 1.5, 0, true);
  }

  /**
   * @brief Sets the camera position for the catcher view
   */
  export function setCatcherView() {
    controls.setPosition(-2.5, 1, 0, true);
  }

  /**
   * @brief Sets the camera position for the side view
   */
  export function setSideView() {
    controls.setPosition(PITCHING_DISTANCE / 2, 0.75, 10, true);
  }

  /**
   * @brief Sets the camera position for the top view
   */
  export function setTopView() {
    controls.setPosition(PITCHING_DISTANCE / 2, 10, 0, true);
  }

  const { dom, invalidate } = useThrelte();

  const camera = new PerspectiveCamera();
  const controls = new CameraControls(camera, dom);

  controls.minDistance = 1.5;
  controls.maxDistance = 18.29;
  controls.maxPolarAngle = Math.PI / 2;

  controls.setBoundary(
    new Box3(
      new Vector3(PITCHING_DISTANCE / 2, 0.75, 0),
      new Vector3(PITCHING_DISTANCE / 2, 0.75, 0)
    )
  );

  controls.setTarget(PITCHING_DISTANCE / 2, 0.75, 0);
  controls.setPosition(-1.5, 1.5, 0.75);

  useTask((delta) => controls.update(delta) && invalidate(), { autoInvalidate: false });
</script>

<T is={camera} makeDefault />
