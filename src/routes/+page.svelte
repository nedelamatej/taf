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
   * @brief Home (organizations) page
   *
   * @author Matej Nedela
   */

  import Table from '$lib/common/Table.svelte';

  let { data } = $props();
</script>

<div class="mx-auto flex max-w-7xl flex-col gap-20 px-10 py-20">
  <div class="flex flex-col gap-2">
    <nav class="flex items-center gap-2 text-sm text-neutral-400">
      <a href="/" class="hover:underline">Home</a>
    </nav>

    <h1 class="text-4xl font-bold">Organizations</h1>
  </div>

  <Table
    data={data.organizations}
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
        value: 'Pitchers',
        type: 'buttonLink',
        width: 1,
        href: '/pitchers/[value.id]'
      },
      {
        value: 'Events',
        type: 'buttonLink',
        width: 2,
        href: '/events/[value.id]'
      }
    ]}
    csvFields={['id', 'name', 'date', 'city', 'country']}
  />
</div>
