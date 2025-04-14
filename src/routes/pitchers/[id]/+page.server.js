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
 * @brief Pitchers page server-side script
 *
 * @author Matej Nedela
 */

/**
 * @brief Load function for the pitchers page
 */
export const load = async ({ fetch, params }) => {
  return {
    pitchers: await (
      await fetch(`https://tranim.nede.cz/api/pitcher/organization/${params.id}`)
    ).json(),
    countries: await (await fetch(`https://tranim.nede.cz/api/country`)).json()
  };
};
