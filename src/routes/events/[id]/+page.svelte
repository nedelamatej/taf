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
   * @brief Events page
   *
   * @author Matej Nedela
   */

  import EventsTable from '$lib/components/EventsTable.svelte';
  import { page } from '$app/state';

  let { data } = $props();
</script>

<div class="mx-auto flex max-w-7xl flex-col gap-20 px-10 py-20">
  <div class="flex flex-col gap-2">
    <nav class="flex items-center gap-2 text-sm text-neutral-400">
      <a href="/" class="hover:underline">Home</a>

      <i class="fa-solid fa-angle-right"></i>

      <a href="/events/{page.params.id}" class="italic hover:underline">
        {data.organization.name}
      </a>
    </nav>

    <h1 class="text-4xl font-bold">Events</h1>
  </div>

  <EventsTable data={data.events} />
</div>
