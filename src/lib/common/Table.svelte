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
   * @brief Table common component
   *
   * @author Matej Nedela
   */

  import IconButton from './IconButton.svelte';
  import Input from './Input.svelte';
  import TableRow from './TableRow.svelte';

  /**
   * @typedef {Object} Props
   *
   * @property {Array<Object<string, any>>} data
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
   * @property {Object<string, any>} defaultValue
   * @property {Array<string>} csvFields
   */

  /** @type {Props} */
  let { data = $bindable(), fields, defaultValue, csvFields } = $props();

  /** @type {HTMLDivElement} */
  let element;

  let findBy = $state('');
  let dataInternal = $derived.by(() => {
    if (findBy) {
      return data
        .map((value, idx) => ({ ...value, _id: idx }))
        .filter((/** @type {any} */ value) =>
          value[fields[0].value]
            .toLowerCase()
            .replaceAll(/\s+/g, '')
            .includes(findBy.toLowerCase().replaceAll(/\s+/g, ''))
        );
    } else {
      return data.map((value, idx) => ({ ...value, _id: idx }));
    }
  });

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

  let copied = $state(false);
</script>

<div class="flex w-full flex-col gap-2">
  <div class="flex justify-between px-1.5">
    <div class="flex gap-2">
      <IconButton
        icon="fa-solid fa-circle-plus"
        onclick={async () => {
          findBy = '';
          data = [...data, defaultValue];

          await new Promise((resolve) => setTimeout(resolve, 0));

          [...element.querySelectorAll('.table_row')].at(-1)?.querySelectorAll('input')[0]?.focus();
        }}
        tooltip="Add"
        shortcut="mod+shift+n"
      />

      <IconButton
        icon={copied ? 'fa-solid fa-check' : 'fa-solid fa-copy'}
        onclick={async () => {
          const csvString = [
            csvFields.join(','),
            ...data.map((row) => csvFields.map((field) => row[field] || '').join(','))
          ].join('\n');

          navigator.clipboard.writeText(csvString);

          copied = true;

          setTimeout(() => (copied = false), 2000);
        }}
        tooltip={copied ? 'Copied!' : 'Copy to clipboard'}
        shortcut={copied ? undefined : 'mod+c'}
      />
    </div>

    <div class="w-80">
      <Input bind:value={findBy} placeholder="Find by..." shortcut="mod+f" />
    </div>
  </div>

  <div class="flex flex-col">
    <div class="flex gap-2 px-1.5">
      <div class="w-10 shrink-0"></div>

      <div class="flex w-full gap-1.5">
        {#each fields as field (field.value)}
          <div
            class="
              {field.width ? flexBasis[field.width] : 'w-10 shrink-0'}
              mb-1 px-3 text-left text-base font-medium text-neutral-600"
          >
            {field.label}
          </div>
        {/each}
      </div>
    </div>

    <div bind:this={element} class="flex flex-col">
      {#each dataInternal as value, rowIdx (rowIdx)}
        <div class="{rowIdx % 2 ? '' : 'bg-neutral-50'} rounded-xl p-1.5">
          <TableRow bind:value={data[value._id]} {fields} {rowIdx} onEdit={() => {}} />
        </div>
      {:else}
        <div class="bg-neutral-50 rounded-xl p-1.5">
          <p class="flex m-0 h-10 items-center justify-center text-base text-neutral-400">
            No data to display.
          </p>
        </div>
      {/each}
    </div>
  </div>
</div>
