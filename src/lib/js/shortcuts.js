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
 * @brief Shortcuts helper script
 *
 * @author Matej Nedela
 */

import { browser } from '$app/environment';

const Shortcuts = (function () {
  /**
   * @brief Gets the shortcut for the index
   *
   * @param {number} idx - index
   *
   * @return {string | undefined} - shortcut
   */
  function getIdxShortcut(idx) {
    return idx < 10 ? `mod+shift+${(idx + 1) % 10}` : undefined;
  }

  /**
   * @breif Gets the label for the shortcut
   *
   * @param {string} shortcut - shortcut
   *
   * @return {string} - label
   */
  function getLabel(shortcut) {
    shortcut = shortcut.toUpperCase().replaceAll('+', '&nbsp;');

    shortcut = (browser && /Mac|iPod|iPhone|iPad/.test(navigator.platform))
      ? shortcut
          .replace('MOD', '<span class="ms-rounded"> keyboard_command_key </span>')
          .replace('ALT', '<span class="ms-rounded"> keyboard_option_key </span>')
      : shortcut.replace('MOD', 'Ctrl').replace('ALT', 'Alt');

    return shortcut
      .replace('SHIFT', '<span class="ms-rounded"> shift </span>')
      .replace('ENTER', '<span class="ms-rounded"> keyboard_return </span>')
      .replace('BACKSPACE', '<span class="ms-rounded"> keyboard_backspace </span>')
      .replace('LEFT', '<span class="ms-rounded"> keyboard_arrow_left </span>')
      .replace('RIGHT', '<span class="ms-rounded"> keyboard_arrow_right </span>');
  }

  return {
    getIdxShortcut,
    getLabel
  };
})();

export default Shortcuts;
