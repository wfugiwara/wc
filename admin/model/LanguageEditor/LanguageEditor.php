<?php

/*

    Language Editor - An open source editor for modifying the language files
    for the front end of OpenCart.
    Copyright (C) 2013 Na'ven Goodkarma

    This program is free software: you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation, either version 3 of the License, or
    (at your option) any later version.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with this program.  If not, see <http://www.gnu.org/licenses/>.

*/

class ModelLanguageEditorLanguageEditor extends Model {

    public function getLanguage($language_id) {

        $query = $this->db->query("SELECT DISTINCT * FROM " . DB_PREFIX . "language WHERE language_id = '" . (int)$language_id . "'");

        return $query->row['filename'];

    }
    
}
?>
