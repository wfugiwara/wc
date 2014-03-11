<?php
// Button
$_['button_backup']        = 'Backup';
$_['button_cancel']        = 'Cancelar';
$_['button_clear']         = 'Limpar';
$_['button_download_log']  = 'Download Log';
$_['button_vqcache_dump']  = 'Download Vqcache';

// Heading
$_['heading_title']        = 'Gerenciador VQMod';

// Columns
$_['column_action']        = 'Instalar / Desinstalar';
$_['column_author']        = 'Autor';
$_['column_delete']        = 'Excluir';
$_['column_file_name']     = 'Nome do Arquivo';
$_['column_id']            = 'Nome / Descrição';
$_['column_status']        = 'Situação';
$_['column_version']       = 'Versão';
$_['column_vqmver']        = 'Versão VQMod';

// Entry
$_['entry_author']         = 'Autor:'; // Change
$_['entry_backup']         = 'Backup VQMod Scripts:';
$_['entry_ext_store']      = 'Versão mais recente:';
$_['entry_ext_version']    = 'Versão do Gerenciador de VQMod:';
$_['entry_forum']          = 'OpenCart Fórum discussão:';
$_['entry_license']        = 'Licença:';
$_['entry_upload']         = 'VQMod Script Upload:';
$_['entry_vqcache']        = 'VQMod Cache:';
$_['entry_vqmod_path']     = 'Caminho VQMod:';
$_['entry_website']        = 'Site:';

// Text Highlighting
$_['highlight']            = '<span class="highlight">%s</span>';

// VQMod Manager Use Errors
$_['error_delete']         = 'Aviso: Não é possível excluir roteiro VQMod!';
$_['error_filetype']       = 'Aviso: Tipo de arquivo inválido! Por favor, só fazer upload de arquivos xml.';
$_['error_install']        = 'Aviso: Não é possível instalar roteiro VQMod!';
$_['error_invalid_xml']    = 'Aviso: VQMod roteiro sintaxe XML não parece ser válido!';
$_['error_log_size']       = 'Aviso: O seu log de erro VQMod é %sMBs.  O limite para o Gerenciador de VQMod é 6MB. Se você precisa ver os erros que você deve baixar o log por FTP. Caso contrário, considerar limpá-lo abaixo.';
$_['error_log_download']   = 'Aviso: Não tem logs de erros disponível para download!';
$_['error_moddedfile']     = 'Aviso: as tentativas de script para VQMod arquivo mod \'%s\' Que não parecem existir!';
$_['error_move']           = 'Aviso: Não é possível salvar o arquivo no servidor. Por favor, verifique as permissões do diretório.';
$_['error_permission']     = 'Aviso: Você não tem permissão para modificar o Gerenciador de módulo VQMod!';
$_['error_uninstall']      = 'Aviso: Não é possível desinstalar o roteiro VQMod!';
$_['error_vqmod_opencart'] = 'Aviso: \'vqmod_opencart.xml\' é necessário para VQMod funcionar adequadamente!';

// $_FILE Upload Errors
$_['error_form_max_file_size'] = 'Aviso: VQMod script excede o tamanho máximo permitido!';
$_['error_ini_max_file_size']  = 'Aviso: VQMod script excede o tamanho do arquivo php. ini máximo!';
$_['error_no_temp_dir']        = 'Aviso: nenhum diretório temporário encontrado!';
$_['error_no_upload']          = 'Aviso: nenhum arquivo selecionado para upload!';
$_['error_partial_upload']     = 'Aviso: Upload incompleta!';
$_['error_php_conflict']       = 'Aviso: conflito desconhecido PHP!';
$_['error_unknown']            = 'Aviso: erro desconhecido!';
$_['error_write_fail']         = 'Aviso: falha ao gravar o script VQMod!';

// VQMod Installation Errors
$_['error_error_log_write']            = 'Unable to write to VQMod error log!  Please set "<span class="error-install">/vqmod</span>" directory permissions to 755 or 777 and try again.';
$_['error_error_logs_write']           = 'Unable to write to VQMod error log!  Please set "<span class="error-install">/vqmod/logs</span>" directory permissions to 755 or 777 and try again.';
$_['error_opencart_version']           = 'OpenCart 1.5.x or later is required to use VQMod Manager!';
$_['error_opencart_xml']               = 'Required file "<span class="error-install">/vqmod/xml/vqmod_opencart.xml</span>" does not appear to exist!  Please install the latest OpenCart-compatible version of VQMod from <a href="http://code.google.com/p/vqmod/" target="_blank">http://code.google.com/p/vqmod/</a> and try again.';
$_['error_opencart_xml_disabled']      = 'Warning: "<span class="error-install">vqmod_opencart.xml</span>" is disabled!  VQMod scripts will not function!';
$_['error_opencart_xml_version']       = 'You appear to be using a version of "<span class="error-install">vqmod_opencart.xml</span>" that is out-of-date for your OpenCart version!  Please install the latest OpenCart-compatible version of VQMod from <a href="http://code.google.com/p/vqmod/" target="_blank">http://code.google.com/p/vqmod/</a> and try again.';
$_['error_vqcache_dir']                = 'Required directory "<span class="error-install">/vqmod/vqcache</span>" does not appear to exist!  Please install the latest OpenCart-compatible version of VQMod from <a href="http://code.google.com/p/vqmod/" target="_blank">http://code.google.com/p/vqmod/</a> and try again.';
$_['error_vqcache_write']              = 'Unable to write to "<span class="error-install">/vqmod/vqcache</span>" directory!  Set permissions to 755 or 777 and try again.';
$_['error_vqcache_files_missing']      = 'VQMod does not appear to be properly generating vqcache files!';
$_['error_vqmod_core']                 = 'Required file "<span class="error-install">vqmod.php</span>" is missing!  Please install the latest OpenCart-compatible version of VQMod from <a href="http://code.google.com/p/vqmod/" target="_blank">http://code.google.com/p/vqmod/</a> and try again.';
$_['error_vqmod_dir']                  = 'The "<span class="error-install">/vqmod</span>" directory does not appear to exist!';
$_['error_vqmod_install_link']         = 'VQMod does not appear to have been integrated with OpenCart!  Please run the VQMod installer at <a href="%1$s">%1$s</a>.  If you have previously run the installer ensure that you are using the latest version of VQMod found at <a href="http://code.google.com/p/vqmod/" target="_blank">http://code.google.com/p/vqmod/</a>.';
$_['error_vqmod_opencart_integration'] = 'VQMod does not appear to have been integrated with OpenCart!  Please install the latest OpenCart-compatible version of VQMod from <a href="http://code.google.com/p/vqmod/" target="_blank">http://code.google.com/p/vqmod/</a> and try again.';
$_['error_vqmod_script_dir']           = 'Required directory "<span class="error-install">/vqmod/xml</span>" does not appear to exist!  Please install the latest OpenCart-compatible version of VQMod from <a href="http://code.google.com/p/vqmod/" target="_blank">http://code.google.com/p/vqmod/</a> and try again.';
$_['error_vqmod_script_write']         = 'Unable to write to "<span class="error-install">/vqmod/xml</span>" directory!  Please set directory permissions to 755 or 777 and try again.';

// VQMod Manager Dependency Errors
$_['error_simplexml']       = '<a href="http://php.net/manual/en/book.simplexml.php" target="_blank">SimpleXML</a> must be installed for VQMod Manager to work properly!  Contact your host for more info.';
$_['error_ziparchive']      = '<a href="http://php.net/manual/en/class.ziparchive.php" target="_blank">ZipArchive</a> must be installed to download VQMod script files!  Contact your host for more info.';

// VQMod Log Errors
$_['error_mod_aborted']       = 'Mod Abortado';
$_['error_mod_skipped']       = 'Operação pulado';

// VQMod Variable Settings
$_['setting_cachetime']       = 'cacheTime:<br /><span class="help">Deprecated as of VQMod 2.2.0</span>';
$_['setting_dir_separator']   = 'Directory Separator:';
$_['setting_logfolder']       = 'Log Folder:<br /><span class="help">VQMod 2.2.0 and later</span>';
$_['setting_logging']         = 'Log de Erros:';
$_['setting_modcache']        = 'modCache:';
$_['setting_path_replaces']   = 'Path Replacements:<br /><span class="help">Changes do not go into effect until the mods.cache file is deleted.</span>';
$_['setting_protected_files'] = 'Protected Files:';
$_['setting_usecache']        = 'useCache:<br /><span class="help">Deprecated as of VQMod 2.1.7</span>';

// Success
$_['success_clear_vqcache']   = 'Sucesso: Cache de VQMod limpo!';
$_['success_clear_log']       = 'Sucesso: Log de erro VQMod limpo!';
$_['success_delete']          = 'Sucesso: Roteiro VQMod apagado!';
$_['success_install']         = 'Sucesso: Roteiro VQMod instalado!';
$_['success_uninstall']       = 'Sucesso: Roteiro VQMod desinstalado!';
$_['success_upload']          = 'Sucesso: Roteiro VQMod carregado!';

// Tabs
$_['tab_about']              = 'Sobre';
$_['tab_error_log']          = 'Log de Erros';
$_['tab_settings']           = 'Configurações e Manutenção';
$_['tab_scripts']            = 'VQMod Scripts';

// Text
$_['text_autodetect']       = 'VQMod parece estar instalado no seguinte caminho. Pressione Salvar para confirmar caminho e instalação completa.';
$_['text_autodetect_fail']  = 'Não foi possível detectar a instalação VQMod. Por favor baixe e instale o <a href="http://code.google.com/p/vqmod/downloads/list" target="_blank">versão mais recente</a> ou digite o caminho não-padrão de instalação do servidor.';
$_['text_delete']           = 'Excluir';
$_['text_disabled']         = 'Desabilitado';
$_['text_enabled']          = 'Habilitado';
$_['text_install']          = 'Instalar';
$_['text_module']           = 'Módulo';
$_['text_no_results']       = 'Não foram encontrados roteiros VQMod!';
$_['text_separator']        = ' &rarr; ';
$_['text_success']          = 'Success: Sucesso: Você modificou o módulo gerenciador de VQMod';
$_['text_unavailable']      = '&mdash;';
$_['text_uninstall']        = 'Desinstalar';
$_['text_upload']           = 'Upload';
$_['text_usecache_help']    = 'useCache está obsoleto a partir de VQMod 2.1.7'; // @TODO
$_['text_vqcache_help']     = 'Limpa o conteúdo do diretório vqcache e exclui o arquivo mods.cache. Alguns arquivos de sistema sempre estará presentes, mesmo depois de limpar o cache.';

// Version
$_['vqmod_manager_author']  = 'rph';
$_['vqmod_manager_license'] = 'Attribution-NonCommercial-ShareAlike 3.0 Unported (CC BY-NC-SA 3.0)';
$_['vqmod_manager_version'] = '2.0';

// Javascript Warnings
$_['warning_required_delete']    = 'WARNING: Deleting \\\'vqmod_opencart.xml\\\' will cause VQMod to STOP WORKING!  Continue?';
$_['warning_required_uninstall'] = 'WARNING: Uninstalling \\\'vqmod_opencart.xml\\\' will cause VQMod to STOP WORKING!  Continue?';
$_['warning_vqmod_delete']       = 'WARNING: Deleting a VQMod script cannot be undone!  Are you sure you want to do this?';
?>