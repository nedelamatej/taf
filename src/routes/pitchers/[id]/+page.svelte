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
   * @brief Pitchers page
   *
   * @author Matej Nedela
   */

  import PitchersTable from '$lib/components/PitchersTable.svelte';

  let { data } = $props();
</script>

<div class="mx-auto flex max-w-7xl flex-col gap-20 px-10 py-20">
  <h1 class="text-4xl font-bold">Pitchers</h1>

  <PitchersTable data={data.pitchers} />
</div>
