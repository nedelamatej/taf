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
  const pitchRes = await fetch(
    `https://tranim.nede.cz/api/pitch/${params.eventId}/${params.pitcherId}/${params.idx}`
  );

  const pitch = await pitchRes.json();

  const typesRes = await fetch(`https://tranim.nede.cz/api/type`);
  const types = await typesRes.json();

  return {
    pitch: pitch,
    types: types
  };
};
