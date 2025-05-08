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
   * @brief Events (by pitcher) page
   *
   * @author Matej Nedela
   */

  import EventsTable from '$lib/components/EventsTable.svelte';
  import { page } from '$app/state';

  let { data } = $props();
</script>

<svelte:head>
  <title>Tranim App | Events</title>
</svelte:head>

<div class="mx-auto flex max-w-7xl flex-col gap-20 px-10 py-20">
  <div class="flex flex-col gap-2">
    <nav class="flex items-center gap-2 text-sm text-neutral-400">
      <a href="/" class="hover:underline">Home</a>

      <i class="fa-solid fa-angle-right"></i>

      <a href="/pitchers/{page.params.id}" class="italic hover:underline">
        {data.organization.name} <span class="not-italic">pitchers</span>
      </a>

      <i class="fa-solid fa-angle-right"></i>

      <a href="/events/{page.params.id}/{page.params.pitcherId}" class="italic hover:underline">
        {data.pitcher.lastName.toUpperCase()}
        {data.pitcher.firstName}
      </a>
    </nav>

    <h1 class="text-4xl font-bold">
      Events
      <span class="font-normal">
        &mdash;

        {data.pitcher.lastName.toUpperCase()}
        {data.pitcher.firstName}
      </span>
    </h1>
  </div>

  <EventsTable data={data.events} pitcherId={data.pitcher.id} />
</div>
