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
  return {
    organizations: await (await fetch(`https://tranim.nede.cz/api/organization`)).json(),
    countries: await (await fetch(`https://tranim.nede.cz/api/country`)).json()
  };
};
