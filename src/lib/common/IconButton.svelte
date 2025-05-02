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
   * @brief Icon button common component
   *
   * @author Matej Nedela
   */

  import Mousetrap from 'mousetrap';
  import Tooltip from './Tooltip.svelte';
  import { onDestroy, onMount } from 'svelte';
  import { browser } from '$app/environment';

  /**
   * @typedef {Object} Props
   *
   * @property {string} icon - fontawesome icon (e.g. 'fa-house')
   * @property {string} [smallIcon] - fontawesome icon (e.g. 'fa-house')
   * @property {() => void} onclick
   * @property {string} [tooltip]
   * @property {string} [shortcut] - mousetrap shortcut (e.g. 'mod+enter', 'mod+backspace', 'alt+a')
   * @property {boolean} [stopPropagation]
   * @property {boolean} [disabled]
   * @property {string} [cssClass]
   */

  /** @type {Props} */
  let {
    icon,
    smallIcon = undefined,
    onclick,
    tooltip = undefined,
    shortcut = undefined, // mousetrap shortcut (e.g. 'mod+enter', 'mod+backspace', 'alt+a')
    stopPropagation = false,
    disabled = false,
    cssClass = ''
  } = $props();

  onMount(() => {
    if (shortcut && !disabled) {
      Mousetrap.bind(shortcut, () => {
        onclick();

        return false;
      });
    }
  });

  onDestroy(() => {
    if (browser && shortcut) {
      // @ts-ignore
      Mousetrap.unbind(shortcut);
    }
  });
</script>

<Tooltip value={tooltip} {shortcut}>
  <button
    onclick={(e) => {
      if (stopPropagation) e.stopPropagation();
      onclick();
    }}
    {disabled}
    type="button"
    class="{cssClass} relative inline-flex h-10 w-10 shrink-0 cursor-pointer items-center justify-center rounded-md border-0 bg-transparent text-lg text-orange-500 ring-2 ring-transparent outline-none ring-inset hover:text-orange-400 focus-visible:ring-orange-500 disabled:cursor-not-allowed disabled:text-orange-300"
    data-tooltip={tooltip}
  >
    <i class={icon}></i>

    {#if smallIcon}
      <i
        style="-webkit-text-stroke: 0.04375rem #FFFFFF;"
        class="{smallIcon} absolute right-1.5 bottom-1.5 text-sm leading-none"
      ></i>
    {/if}
  </button>
</Tooltip>
