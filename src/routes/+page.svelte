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

  let organizations = $state(data.organizations);
</script>

<div class="mx-auto flex max-w-7xl flex-col gap-20 px-10 py-20">
  <h1 class="text-4xl font-bold">Organizations</h1>

  <Table
    bind:data={organizations}
    fields={[
      {
        value: 'name',
        label: 'Name',
        type: 'input',
        width: 8
      },
      {
        value: 'country',
        label: 'Country',
        type: 'listbox',
        width: 2,
        elements: data.countries.map((/** @type {any} */ country) => ({
          value: country.id,
          label: country.name,
          append: country.code.toUpperCase()
        }))
      },
      {
        value: 'Events',
        type: 'buttonLink',
        width: 1,
        href: '/events/[value.id]'
      },
      {
        value: 'Pitchers',
        type: 'buttonLink',
        width: 1,
        href: '/pitchers/[value.id]'
      }
    ]}
    defaultValue={{}}
    csvFields={['id', 'name', 'date', 'city', 'country']}
  />
</div>
