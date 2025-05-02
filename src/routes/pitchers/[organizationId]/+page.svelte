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

  import Table from '$lib/common/Table.svelte';

  let { data } = $props();

  let pitchers = $state(data.pitchers);
</script>

<div class="mx-auto flex max-w-7xl flex-col gap-20 px-10 py-20">
  <h1 class="text-4xl font-bold">Pitchers</h1>

  <Table
    bind:data={pitchers}
    fields={[
      {
        value: 'name',
        label: 'Name',
        type: 'text',
        width: 3,
        cssClass: 'font-bold'
      },
      {
        value: 'date',
        label: 'Date',
        type: 'text',
        width: 2,
        cssClass: 'font-mono'
      },
      {
        value: 'city',
        label: 'City',
        type: 'text',
        width: 2
      },
      {
        value: 'country',
        label: 'Country',
        type: 'text',
        width: 2
      },
      {
        value: 'Events',
        type: 'buttonLink',
        width: 1,
        href: '/pitchers/[page.params.id]/[value.id]'
      },
      {
        value: 'Pitches',
        type: 'buttonLink',
        width: 2,
        primary: true,
        href: '/pitch/0/[value.id]/1'
      }
    ]}
    csvFields={['id', 'organization', 'name', 'date', 'city', 'country']}
  />
</div>
