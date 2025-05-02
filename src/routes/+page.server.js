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
 * @brief Home (organizations) page server-side script
 *
 * @author Matej Nedela
 */

/**
 * @brief Load function for the home (organizations) page
 */
export const load = async ({ fetch }) => {
  const organizationsRes = await fetch(`https://tranim.nede.cz/api/organization`);
  const organizations = await organizationsRes.json();

  const countriesRes = await fetch(`https://tranim.nede.cz/api/country`);
  const countries = await countriesRes.json();

  organizations.forEach((/** @type {any} */ organization) => {
    organization.country = countries.find((/** @type {any} */ country) => country.id === organization.country).name;
  })

  return {
    organizations: organizations
  };
};
