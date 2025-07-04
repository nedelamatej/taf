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
   * @brief Button common component
   *
   * @author Matej Nedela
   */

  import Mousetrap from 'mousetrap';
  import Shortcuts from '../js/shortcuts.js';
  import { onDestroy, onMount } from 'svelte';
  import { browser } from '$app/environment';

  /**
   * @typedef {Object} Props
   *
   * @property {boolean} [primary]
   * @property {boolean} [secondary]
   * @property {string} value
   * @property {() => void} onclick
   * @property {string} [icon] - fontawesome icon (e.g. 'fa-house')
   * @property {string} [badge]
   * @property {string} [badgeIcon]
   * @property {string} [shortcut] - mousetrap shortcut (e.g. 'mod+enter', 'mod+backspace', 'alt+a')
   * @property {boolean} [stopPropagation]
   * @property {boolean} [disabled]
   * @property {'center' | 'start'} [justifyContent]
   * @property {'absolute' | 'static'} [childrenPosition]
   * @property {boolean} [transparent]
   * @property {string} [cssClass]
   */

  /** @type {Props} */
  let {
    primary = false,
    secondary = false,
    value,
    onclick,
    icon = undefined,
    badge = undefined,
    badgeIcon = undefined,
    shortcut = undefined,
    stopPropagation = false,
    disabled = false,
    justifyContent = 'center',
    childrenPosition = 'absolute',
    transparent = false,
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

<button
  onclick={(e) => {
    if (stopPropagation) e.stopPropagation();
    onclick();
  }}
  {disabled}
  type="button"
  class="
    {cssClass}
    {primary
    ? 'bg-orange-500 text-white ring-orange-500 hover:bg-orange-400 hover:ring-orange-400 focus-visible:outline-orange-500 disabled:bg-orange-300 disabled:ring-orange-300'
    : ''}
    {secondary
    ? `${transparent ? 'bg-transparent' : 'bg-white'} text-neutral-800 ring-neutral-300 hover:bg-neutral-200 focus-visible:ring-2 focus-visible:ring-orange-500 disabled:bg-neutral-100`
    : ''}
    justify-{justifyContent} relative inline-flex w-full cursor-pointer items-center gap-x-3 rounded-md border-0 px-3 py-2 text-base shadow-sm ring-1 outline-2 outline-offset-2 outline-transparent ring-inset disabled:cursor-not-allowed"
>
  {#if badge && !primary}
    <span
      class="group {childrenPosition} inset-y-2 left-2 inline-flex items-center rounded bg-cyan-600 px-1.5 py-0.5 text-sm font-medium text-white"
    >
      {#if badgeIcon}
        <i class="w-6 {badgeIcon}"></i>

        <span
          class="inline-flex max-w-0 overflow-hidden whitespace-nowrap group-hover:max-w-[144px]"
        >
          <span class="pl-2">
            {badge}
          </span>
        </span>
      {:else}
        {badge}
      {/if}
    </span>
  {/if}

  {#if icon}
    <i class="w-6 {icon}"></i>
  {/if}

  {value}

  {#if shortcut && !disabled}
    <kbd
      class="
        {primary ? 'bg-orange-400 text-white ring-orange-400' : ''}
        {secondary ? 'bg-white text-neutral-400 ring-neutral-300' : ''}
        {childrenPosition} inset-y-2 right-3 -mr-1 inline-flex items-center rounded px-1.5 py-0.5 font-sans text-sm font-bold shadow-none ring-1 ring-inset"
    >
      <!-- eslint-disable-next-line svelte/no-at-html-tags -->
      {@html Shortcuts.getLabel(shortcut)}
    </kbd>
  {/if}
</button>
