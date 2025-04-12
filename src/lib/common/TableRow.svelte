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
   * @brief Table row common component
   *
   * @author Matej Nedela
   */

  import Input from './Input.svelte';
  import Listbox from './Listbox.svelte';
  import Combobox from './Combobox.svelte';
  import Button from './Button.svelte';
  import ButtonLink from './ButtonLink.svelte';
  import IconButton from './IconButton.svelte';
  import IconButtonLink from './IconButtonLink.svelte';
  import Shortcuts from '../js/shortcuts.js';
  import { page } from '$app/state';

  /**
   * @typedef {Object} Props
   *
   * @property {Object<string, any>} value
   * @property {Array<{
   *   value: string,
   *   label?: string | undefined,
   *   default?: any | undefined,
   *   type: 'input' | 'combobox' | 'listbox' | 'button' | 'buttonLink' | 'iconButton' | 'iconButtonLink',
   *   width?: 1 | 2 | 3 | 4 | 5 | 6 | 7 | 8 | 9 | 10 | 11 | 12 | undefined,
   *   elements?: Array<{ value: string, label: string, append?: string }> | undefined,
   *   customValues?: boolean | undefined,
   *   placeholder?: string | undefined,
   *   maxlength?: number | undefined,
   *   uppercase?: boolean | undefined,
   *   disabled?: boolean | undefined,
   *   primary?: boolean | undefined,
   *   icon?: string | undefined,
   *   onclick?: () => void,
   *   href?: string | undefined,
   *   tooltip?: string | undefined,
   *   stopPropagation?: boolean | undefined,
   * }>} fields
   * @property {number} rowIdx
   * @property {() => void} onEdit
   */

  /** @type {Props} */
  let { value = $bindable(), fields, rowIdx, onEdit } = $props();

  const flexBasis = {
    1: 'basis-1/12',
    2: 'basis-2/12',
    3: 'basis-3/12',
    4: 'basis-4/12',
    5: 'basis-5/12',
    6: 'basis-6/12',
    7: 'basis-7/12',
    8: 'basis-8/12',
    9: 'basis-9/12',
    10: 'basis-10/12',
    11: 'basis-11/12',
    12: 'basis-12/12'
  };
</script>

<div class="table_row flex gap-2">
  <IconButton icon="fa-solid fa-pen-to-square" onclick={onEdit} tooltip="Edit" />

  <div class="flex w-full gap-1.5">
    {#each fields as field, columnIdx (field.value)}
      <div class={field.width ? flexBasis[field.width] : 'w-10 shrink-0'}>
        {#if field.type === 'input'}
          <Input
            bind:value={value[field.value]}
            placeholder={field.placeholder}
            shortcut={columnIdx === 0 ? Shortcuts.getIdxShortcut(rowIdx) : undefined}
            maxlength={field.maxlength}
            uppercase={field.uppercase}
            disabled={field.disabled}
            transparent={true}
          />
        {:else if field.type === 'listbox'}
          <Listbox
            bind:value={value[field.value]}
            elements={field.elements || []}
            shortcut={columnIdx === 0 ? Shortcuts.getIdxShortcut(rowIdx) : undefined}
            disabled={field.disabled}
            transparent={true}
          />
        {:else if field.type === 'combobox'}
          <Combobox
            bind:value={value[field.value]}
            elements={field.elements || []}
            customValues={field.customValues}
            placeholder={field.placeholder}
            shortcut={columnIdx === 0 ? Shortcuts.getIdxShortcut(rowIdx) : undefined}
            maxlength={field.maxlength}
            uppercase={field.uppercase}
            disabled={field.disabled}
            transparent={true}
          />
        {:else if field.type === 'button'}
          <Button
            primary={field.primary}
            secondary={!field.primary}
            value={field.value}
            onclick={field.onclick || (() => {})}
            icon={field.icon}
            shortcut={columnIdx === 0 ? Shortcuts.getIdxShortcut(rowIdx) : undefined}
            stopPropagation={field.stopPropagation}
            disabled={field.disabled}
            transparent={true}
          />
        {:else if field.type === 'buttonLink'}
          <ButtonLink
            primary={field.primary}
            secondary={!field.primary}
            value={field.value}
            href={field.href
              ?.replace('[value.id]', value.id)
              ?.replace('[page.params.id]', page.params.id) ?? ''}
            icon={field.icon}
            shortcut={columnIdx === 0 ? Shortcuts.getIdxShortcut(rowIdx) : undefined}
            disabled={field.disabled}
            transparent={true}
          />
        {:else if field.type === 'iconButton'}
          <IconButton
            icon={field.icon ?? ''}
            onclick={field.onclick || (() => {})}
            tooltip={field.tooltip}
            shortcut={columnIdx === 0 ? Shortcuts.getIdxShortcut(rowIdx) : undefined}
            stopPropagation={field.stopPropagation}
            disabled={field.disabled}
          />
        {:else if field.type === 'iconButtonLink'}
          <IconButtonLink
            icon={field.icon ?? ''}
            href={field.href
              ?.replace('[value.id]', value.id)
              ?.replace('[page.params.id]', page.params.id) ?? ''}
            tooltip={field.tooltip}
            shortcut={columnIdx === 0 ? Shortcuts.getIdxShortcut(rowIdx) : undefined}
            disabled={field.disabled}
          />
        {/if}
      </div>
    {/each}
  </div>
</div>
