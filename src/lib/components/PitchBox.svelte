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
   * @brief Pitch box component
   *
   * @author Matej Nedela
   */

  /**
   * @typedef {Object} Props
   *
   * @property {any} pitch
   * @property {any} pitch1
   * @property {any} pitch2
   */

  /** @type {Props} */
  let { pitch, pitch1, pitch2 } = $props();

  let comp1 = $derived.by(async () => {
    if (pitch1) {
      const response = await fetch(`https://tranim.nede.cz/api/pitch/${pitch.id}/${pitch1.id}`);
      return await response.json();
    } else {
      return undefined;
    }
  });

  let comp2 = $derived.by(async () => {
    if (pitch2) {
      const response = await fetch(`https://tranim.nede.cz/api/pitch/${pitch.id}/${pitch2.id}`);
      return await response.json();
    } else {
      return undefined;
    }
  });
</script>

<div class="flex w-[calc((100%-36px)/4)] flex-col gap-2 rounded-lg bg-orange-100/42 px-3 py-2">
  <div class="flex justify-center text-xs font-light tracking-widest text-orange-500 uppercase">
    Pitch details
  </div>

  <div class="flex flex-col tabular-nums">
    <div class="flex items-center gap-2">
      <i class="fa-solid fa-user !flex h-6 w-4 items-center justify-center"></i>

      <span class="flex grow-1">
        {pitch.pitcher.lastName.toUpperCase()}
        {pitch.pitcher.firstName}
      </span>
    </div>

    <div class="flex items-center gap-2">
      <i class="fa-solid fa-calendar !flex h-6 w-4 items-center justify-center"></i>

      <span class="flex grow-1">
        {pitch.event.name}
      </span>
    </div>

    <div class="flex items-center gap-2">
      <i class="fa-solid fa-clock !flex h-6 w-4 items-center justify-center"></i>

      <span class="flex grow-1">
        {pitch.date} ({pitch.time})
      </span>
    </div>
  </div>

  <div class="-mb-1 flex justify-center gap-2 pl-6 text-xs font-light text-neutral-600 italic">
    <span class="flex grow-1 basis-1/3 justify-center"> Half </span>
    <span class="flex grow-1 basis-1/3 justify-center"> Last </span>
    <span class="flex grow-1 basis-1/3 justify-center"> Diff </span>
  </div>

  <div
    class="-mx-2 -my-1 flex h-14 flex-col justify-center rounded-sm bg-orange-100/42 px-2 py-1 font-mono"
  >
    {#await comp1 then comp1}
      {#if comp1}
        <div class="flex items-center gap-2">
          <i
            class="fa-solid fa-thumbtack !flex h-6 w-4 shrink-0 items-center justify-center text-[#2E7D32]"
          ></i>

          <span class="flex grow-1 basis-1/3 justify-center">
            {Math.round(comp1.half * 100)} %
          </span>
          <span class="flex grow-1 basis-1/3 justify-center">
            {Math.round(comp1.last) * 100} %
          </span>
          <span class="flex grow-1 basis-1/3 justify-center">
            {Math.round(comp1.diff * 100)} cm
          </span>
        </div>
      {/if}
    {/await}

    {#await comp2 then comp2}
      {#if comp2}
        <div class="flex items-center gap-2">
          <i
            class="fa-solid fa-thumbtack !flex h-6 w-4 shrink-0 items-center justify-center text-[#1565C0]"
          ></i>

          <span class="flex grow-1 basis-1/3 justify-center">
            {Math.round(comp2.half * 100)} %
          </span>
          <span class="flex grow-1 basis-1/3 justify-center">
            {Math.round(comp2.last) * 100} %
          </span>
          <span class="flex grow-1 basis-1/3 justify-center">
            {Math.round(comp2.diff * 100)} cm
          </span>
        </div>
      {/if}
    {/await}
  </div>
</div>
