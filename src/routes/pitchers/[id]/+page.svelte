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
        value: 'firstName',
        label: 'First name',
        type: 'input',
        width: 4
      },
      {
        value: 'lastName',
        label: 'Last name',
        type: 'input',
        width: 4
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
        href: '/pitchers/[page.params.id]/[value.id]'
      },
      {
        value: 'Pitches',
        type: 'buttonLink',
        width: 1,
        primary: true,
        href: '/pitch/0/[value.id]/1'
      }
    ]}
    defaultValue={{}}
    csvFields={['id', 'organization', 'firstName', 'lastName', 'date', 'city', 'country']}
  />
</div>
