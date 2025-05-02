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
   * @brief Listbox common component
   *
   * @author Matej Nedela
   */

  import { createListbox } from 'svelte-headlessui';
  import Transition from 'svelte-transition';
  import Mousetrap from 'mousetrap';
  import Shortcuts from '../js/shortcuts.js';
  import { onDestroy, onMount } from 'svelte';
  import { browser } from '$app/environment';

  /**
   * @typedef {Object} Props
   *
   * @property {string} value
   * @property {string} [label]
   * @property {Array<{ value: string, label: string, append?: string }>} elements
   * @property {string} [shortcut] - mousetrap shortcut (e.g. 'mod+enter', 'mod+backspace', 'alt+a')
   * @property {boolean} [disabled]
   * @property {boolean} [transparent]
   */

  /** @type {Props} */
  let {
    value = $bindable(),
    label = undefined,
    elements,
    shortcut = undefined,
    disabled = false,
    transparent = false
  } = $props();

  value = value || elements[0].value;

  let elementsInternal = $derived(elements.map((element) => ({ ...element, name: element.label })));

  /** @type {HTMLButtonElement} */
  let element;
  const elementId = $props.id();

  onMount(() => {
    if (shortcut && !disabled) {
      Mousetrap.bind(shortcut, () => {
        element.click();

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

  const listbox = createListbox({
    label,
    // eslint-disable-next-line svelte/no-unused-svelte-ignore
    // svelte-ignore state_referenced_locally
    selected: elementsInternal.find((element) => element.value === value)
  });
</script>

<div class="_listbox relative w-full">
  {#if label}
    <label for={elementId} class="m-0 mb-1 block text-base font-medium text-neutral-600">
      {label}
    </label>
  {/if}

  <div>
    <button
      use:listbox.button
      bind:this={element}
      onchange={(/** @type {any} */ e) => {
        if (e.detail?.selected) {
          value = e.detail.selected.value;
        }
      }}
      id={elementId}
      {disabled}
      class="
        {transparent ? 'bg-transparent' : 'bg-white'}
        relative w-full cursor-pointer rounded-md border-0 py-2 pr-8 pl-3 text-left text-base text-neutral-800 shadow-sm ring-1 ring-neutral-300 outline-none ring-inset hover:bg-neutral-200 focus:ring-2 focus:ring-orange-500 disabled:cursor-not-allowed disabled:bg-neutral-100 disabled:text-neutral-600"
    >
      {elementsInternal.find((element) => element.value === value)?.label || ''}

      {#if shortcut && !disabled}
        <kbd
          class="absolute inset-y-2 right-8 inline-flex items-center rounded bg-white px-1.5 py-0.5 font-sans text-sm font-bold text-neutral-400 shadow-none ring-1 ring-neutral-300 ring-inset"
        >
          <!-- eslint-disable-next-line svelte/no-at-html-tags -->
          {@html Shortcuts.getLabel(shortcut)}
        </kbd>
      {/if}

      <span class="absolute inset-y-0 right-0 inline-flex items-center pr-2 text-neutral-400">
        <span class="ms-rounded"> expand_all </span>
      </span>
    </button>
  </div>

  <Transition
    show={$listbox.expanded}
    enter="ease-out duration-300"
    enterFrom="opacity-0"
    enterTo="opacity-100"
    leave="ease-in duration-300"
    leaveFrom="opacity-100"
    leaveTo="opacity-0"
  >
    <ul
      use:listbox.items
      class="ring-opacity-50 absolute z-10 mt-1 max-h-60 w-full overflow-auto rounded-md bg-white py-1.5 text-base shadow-md ring-1 ring-neutral-300 outline-none"
    >
      {#each elementsInternal as element (element.name)}
        {@const active = $listbox.active === element}
        {@const selected = $listbox.selected === element}

        <li
          use:listbox.item={{ value: element }}
          class={`
            ${active ? 'bg-orange-500 text-white' : 'text-neutral-800'}
            ${selected ? 'font-bold' : 'font-normal'}
            flex cursor-default gap-3 truncate px-3 py-2 select-none`}
        >
          {element.label}

          {#if element.append}
            <span
              class="
                {active ? 'text-orange-200' : 'text-neutral-400'}
                truncate font-normal"
            >
              {element.append}
            </span>
          {/if}
        </li>
      {/each}
    </ul>
  </Transition>
</div>
