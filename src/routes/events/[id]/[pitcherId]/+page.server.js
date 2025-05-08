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
 * @brief Events (by pitcher) page server-side script
 *
 * @author Matej Nedela
 */

/**
 * @brief Load function for the events (by pitcher) page
 */
export const load = async ({ fetch, params }) => {
  const organizationRes = await fetch(`https://tranim.nede.cz/api/organization/${params.id}`);
  const organization = await organizationRes.json();

  const pitcherRes = await fetch(`https://tranim.nede.cz/api/pitcher/${params.pitcherId}`);
  const pitcher = await pitcherRes.json();

  const eventsRes = await fetch(`https://tranim.nede.cz/api/event/pitcher/${params.pitcherId}`);
  const events = await eventsRes.json();

  const countriesRes = await fetch(`https://tranim.nede.cz/api/country`);
  const countries = await countriesRes.json();

  events.forEach((/** @type {any} */ event) => {
    event.disabled = event.pitchCnt === 0;
    event.country = countries.find(
      (/** @type {any} */ country) => country.id === event.country
    ).name;
  });

  return {
    organization: organization,
    pitcher: pitcher,
    events: events
  };
};
