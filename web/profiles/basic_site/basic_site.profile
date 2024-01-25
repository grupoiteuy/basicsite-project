<?php

/**
 * @file
 * Enables modules and site configuration for a standard site installation.
 */

/**
 * Need to do a manual include since this install profile never actually gets
 * installed so therefore its code cannot be autoloaded.
 */

use Drupal\Core\Form\FormStateInterface;

function basic_site_install_tasks_alter(&$tasks, $install_state) {
  // Ocultamos paso de selección de idioma, lo definimos en el .info del perfil.
  $tasks['install_select_language']['display'] = FALSE;
}
