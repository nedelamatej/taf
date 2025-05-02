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
   * @brief Events table component
   *
   * @author Matej Nedela
   */

  import Table from '$lib/common/Table.svelte';

  let { data } = $props();
</script>

<Table
  {data}
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
      href: '/pitchers/[page.params.id]/[value.id]'
    },
    {
      value: 'Pitches',
      type: 'buttonLink',
      width: 2,
      primary: true,
      href: '/pitch/[value.id]/0/1'
    }
  ]}
  csvFields={['id', 'organization', 'name', 'date', 'city', 'country']}
/>
