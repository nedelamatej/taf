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
   * @brief Tooltip internal common component
   *
   * @author Matej Nedela
   */

  import Shortcuts from '../js/shortcuts.js';

  /**
   * @typedef {Object} Props
   *
   * @property {string} value
   * @property {string} [shortcut] - mousetrap shortcut (e.g. 'mod+enter', 'mod+backspace', 'alt+a')
   */

  /** @type {Props} */
  let { value, shortcut = undefined } = $props();

  /**
   * @brief Gets the element
   *
   * @return {HTMLDivElement} - element
   */
  export function getElement() {
    return element;
  }

  /** @type {HTMLDivElement} */
  let element;
</script>

<div
  bind:this={element}
  class="absolute z-10 hidden w-max items-center justify-center gap-x-3 rounded-md bg-neutral-500 px-3 py-2 text-base text-white"
>
  {value}

  {#if shortcut}
    <kbd
      class="-mr-1 inline-flex h-6 items-center rounded bg-neutral-400 px-1.5 py-0.5 font-sans text-sm font-bold text-white shadow-none"
    >
      <!-- eslint-disable-next-line svelte/no-at-html-tags -->
      {@html Shortcuts.getLabel(shortcut)}
    </kbd>
  {/if}
</div>
