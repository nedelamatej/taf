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
   * @brief Value box component
   *
   * @author Matej Nedela
   */

  /**
   * @typedef {Object} Props
   *
   * @property {string} label
   * @property {string} value
   * @property {string | undefined} value1
   * @property {string | undefined} value2
   */

  /** @type {Props} */
  let { label, value, value1, value2 } = $props();
</script>

<div class="flex w-[calc((100%-36px)/4)] flex-col gap-2 rounded-lg bg-orange-100/42 px-3 py-2">
  <div class="flex justify-center text-xs font-light tracking-widest text-orange-500 uppercase">
    {label}
  </div>

  <div class="flex">
    <div class="flex h-12 grow-1 items-center justify-center text-3xl font-medium tabular-nums">
      <!-- eslint-disable-next-line svelte/no-at-html-tags -->
      {@html value}
    </div>

    {#if value1 || value2}
      <div
        class="-mx-2 -my-1 flex w-[calc(100%/3+8px)] flex-col justify-center rounded-sm bg-orange-100/42 px-2 py-1 font-mono"
      >
        {#if value1}
          <div class="flex items-center gap-2">
            <i
              class="fa-solid fa-thumbtack !flex h-6 w-4 items-center justify-center text-[#2E7D32]"
            ></i>

            <span class="flex grow-1 justify-center">
              <!-- eslint-disable-next-line svelte/no-at-html-tags -->
              {@html value1}
            </span>
          </div>
        {/if}

        {#if value2}
          <div class="flex items-center gap-2">
            <i
              class="fa-solid fa-thumbtack !flex h-6 w-4 items-center justify-center text-[#1565C0]"
            ></i>

            <span class="flex grow-1 justify-center">
              <!-- eslint-disable-next-line svelte/no-at-html-tags -->
              {@html value2}
            </span>
          </div>
        {/if}
      </div>
    {/if}
  </div>
</div>
