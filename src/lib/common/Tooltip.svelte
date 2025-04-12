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
   * @brief Tooltip common component
   *
   * @author Matej Nedela
   */

  import { autoUpdate, computePosition, flip, offset, shift } from '@floating-ui/dom';
  import TooltipInternal from './TooltipInternal.svelte';
  import { mount, onDestroy, onMount, unmount } from 'svelte';
  import { browser } from '$app/environment';

  /**
   * @typedef {Object} Props
   *
   * @property {string} [value]
   * @property {string} [shortcut] - mousetrap shortcut (e.g. 'mod+enter', 'mod+backspace', 'alt+a')
   * @property {any} children
   */

  /** @type {Props} */
  let { value = undefined, shortcut = undefined, children } = $props();

  /** @type {HTMLSpanElement} */
  let element;
  /** @type {TooltipInternal} */
  let component;

  /** @type {() => void} */
  let cleanup;

  /**
   * @brief Shows the tooltip
   */
  function showTooltip() {
    component.getElement().style.display = 'inline-flex';

    cleanup = autoUpdate(element, component.getElement(), updatePosition);
  }

  /**
   * @brief Hides the tooltip
   */
  function hideTooltip() {
    component.getElement().style.display = 'none';

    cleanup();
  }

  /**
   * @brief Updates the position of the tooltip
   */
  function updatePosition() {
    if (element && component.getElement()) {
      computePosition(element, component.getElement(), {
        placement: 'top',

        middleware: [offset(remToPx(0.125)), flip(), shift({ padding: remToPx(0.125) })]
      }).then(({ x, y }) => {
        if (component.getElement()) {
          Object.assign(component.getElement().style, {
            left: `${x}px`,
            top: `${y}px`
          });
        }
      });
    }
  }

  /**
   * @breif Converts rem to px
   *
   * @param {number} rem - value in rem
   *
   * @return {number} - value in px
   */
  function remToPx(rem) {
    return rem * parseFloat(getComputedStyle(document.documentElement).fontSize);
  }

  /** @type {{ value: string | undefined, shortcut: string | undefined }} */
  let componentProps = $state({
    value,
    shortcut
  });

  $effect(() => {
    componentProps.value = value;
    componentProps.shortcut = shortcut;
  });

  onMount(() => {
    if (value) {
      component = mount(TooltipInternal, {
        target: document.body,
        props: componentProps
      });

      [
        ['mouseenter', showTooltip],
        ['mouseleave', hideTooltip],
        ['focus', showTooltip],
        ['blur', hideTooltip]
      ].forEach(([event, listener]) => {
        // @ts-ignore
        element.addEventListener(event, listener);
      });
    }
  });

  onDestroy(() => {
    if (browser && component) {
      unmount(component);
    }
  });
</script>

<span bind:this={element} class="inline-flex">
  {@render children()}
</span>
