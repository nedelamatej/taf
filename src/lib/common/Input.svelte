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
   * @brief Input common component
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
   * @property {string | number | undefined} value
   * @property {string} [label]
   * @property {'text' | 'number'} [type]
   * @property {string} [placeholder]
   * @property {string} [shortcut] - mousetrap shortcut (e.g. 'mod+enter', 'mod+backspace', 'alt+a')
   * @property {number} [minlength]
   * @property {number} [maxlength]
   * @property {number} [min]
   * @property {number} [max]
   * @property {boolean} [uppercase]
   * @property {boolean} [disabled]
   * @property {boolean} [transparent]
   */

  /** @type {Props} */
  let {
    value = $bindable(),
    label = undefined,
    type = 'text',
    placeholder = undefined,
    shortcut = undefined,
    minlength = undefined,
    maxlength = undefined,
    min = undefined,
    max = undefined,
    uppercase = false,
    disabled = false,
    transparent = false
  } = $props();

  /** @type {HTMLInputElement} */
  let element;
  const elementId = $props.id();

  onMount(() => {
    if (shortcut && !disabled) {
      Mousetrap.bind(shortcut, () => {
        element.focus();

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

<div class="_input w-full">
  {#if label}
    <label for={elementId} class="m-0 mb-1 block text-base font-medium text-neutral-600">
      {label}
    </label>
  {/if}

  <div class="relative w-full">
    <input
      bind:value
      bind:this={element}
      id={elementId}
      {type}
      {placeholder}
      {minlength}
      {maxlength}
      {min}
      {max}
      {disabled}
      class="
        {uppercase ? 'uppercase' : ''}
        {transparent ? 'bg-transparent' : 'bg-white'}
        w-full rounded-md border-0 px-3 py-2 text-base text-neutral-800 shadow-sm ring-1 ring-neutral-300 outline-none ring-inset placeholder:text-neutral-400 placeholder:opacity-100 focus:ring-2 focus:ring-orange-500 disabled:cursor-not-allowed disabled:bg-neutral-100 disabled:text-neutral-600"
    />

    {#if shortcut && !disabled}
      <kbd
        class="absolute inset-y-2 right-2 inline-flex items-center rounded bg-white px-1.5 py-0.5 font-sans text-sm font-bold text-neutral-400 shadow-none ring-1 ring-neutral-300 ring-inset"
      >
        <!-- eslint-disable-next-line svelte/no-at-html-tags -->
        {@html Shortcuts.getLabel(shortcut)}
      </kbd>
    {/if}
  </div>
</div>

<style>
  input[type='number'] {
    appearance: textfield;
  }
</style>
