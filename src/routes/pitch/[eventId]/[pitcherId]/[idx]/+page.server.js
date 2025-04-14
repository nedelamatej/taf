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
 * @brief Pitch page server-side script
 *
 * @author Matej Nedela
 */

/**
 * @brief Load function for the pitch page
 */
export const load = async ({ fetch, params }) => {
  return {
    pitch: await (
      await fetch(
        `https://tranim.nede.cz/api/pitch/${params.eventId}/${params.pitcherId}/${params.idx}`
      )
    ).json(),
    types: await (await fetch(`https://tranim.nede.cz/api/type`)).json()
  };
};
