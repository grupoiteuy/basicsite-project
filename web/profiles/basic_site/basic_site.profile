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

/**
 * Implements hook_form_FORM_ID_alter() for install_configure_form().
 *
 * Allows the profile to alter the site settings form.
 */
function basic_site_form_install_settings_form_alter(&$form, FormStateInterface $form_state, $form_id) {
  $form['settings']['mysql']['database']['#title']         = $form['settings']['mysql']['database']['#title'] . ' (tipo cpanel)';
  $form['settings']['mysql']['database']['#default_value'] = '_drupal9';
  $form['settings']['mysql']['database']['#description']   = t('Utilice como prefijo los 8 primeros caracteres del dominio');

  $form['settings']['mysql']['username']['#default_value'] = 'root';
}

/**
 * Implements hook_form_FORM_ID_alter() for install_configure_form().
 *
 * Allows the profile to alter the site configuration form.
 */
function basic_site_form_install_configure_form_alter(&$form, FormStateInterface $form_state, $form_id) {
  $form['site_information']['site_name']['#description'] = t('Ej: Grupo ITe');

  $form['site_information']['basic_site_slogan'] = array(
    '#type'        => 'textfield',
    '#title'       => t('Slogan'),
    '#description' => t('Ej: Desarrollo Web'),
    '#weight'      => -19,
  );

  $form['site_information']['site_mail']['#default_value'] = 'info@grupoite.com.uy';

  // Account information defaults.
  $form['admin_account']['account']['name']['#default_value'] = 'adminSITE';
  $form['admin_account']['account']['name']['#description'] = 'Reemplace SITE por el nombre del sitio sin espacios';
  $form['admin_account']['account']['mail']['#default_value'] = 'info@grupoite.com.uy';

  // Date/time settings.
  $form['regional_settings']['site_default_country']['#default_value']  = 'UY';
  $form['regional_settings']['date_default_timezone']['#default_value'] = 'America/Montevideo';

  $form['update_notifications']['enable_update_status_emails']['#default_value'] = 0;

  $form['#submit'][] = 'basic_site_form_install_configure_submit';
}

function basic_site_form_install_configure_submit($form, FormStateInterface $form_state) {
  // Guardar el nombre y slogan del sitio.
  $site_name = $form_state->getValue('site_name');
  \Drupal::configFactory()
         ->getEditable('system.site')
         ->set('name', $site_name)
         ->save(TRUE);
  $site_slogan = $form_state->getValue('basic_site_slogan');
  \Drupal::configFactory()
         ->getEditable('system.site')
         ->set('slogan', $site_slogan)
         ->save(TRUE);
}
