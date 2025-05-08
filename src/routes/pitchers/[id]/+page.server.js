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
  const organizationRes = await fetch(`https://tranim.nede.cz/api/organization/${params.id}`);
  const organization = await organizationRes.json();

  const pitchersRes = await fetch(`https://tranim.nede.cz/api/pitcher/organization/${params.id}`);
  const pitchers = await pitchersRes.json();

  const countriesRes = await fetch(`https://tranim.nede.cz/api/country`);
  const countries = await countriesRes.json();

  pitchers.forEach((/** @type {any} */ pitcher) => {
    pitcher.disabled = pitcher.pitchCnt === 0;
    pitcher.name = pitcher.lastName.toUpperCase() + ' ' + pitcher.firstName;
    pitcher.country = countries.find(
      (/** @type {any} */ country) => country.id === pitcher.country
    ).name;
  });

  return {
    organization: organization,
    pitchers: pitchers
  };
};
