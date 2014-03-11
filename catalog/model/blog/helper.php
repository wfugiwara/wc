<?php
// Info: Pseudo helper coz OpenCart "helper" in system folder not allow us to use OC function.

class ModelBlogHelper extends Model {
   public function date_format($date, $format='') {
      // This function to support multilanguage for the month name. Somehow setlocale() is not show localize name on most server
      // $format : dfs (date format short), dfl (date format long), dtf (date time format)
      
      $this->language->load('blog/blog');
      
      $date_format         = $this->language->get('date_format');
      $date_time_format    = $this->language->get('date_time_format');
      
      $timedate   = strtotime($date);

      if (is_array($this->language->get('month_short'))) {
         $day_short     = $this->language->get('day_short');
         $day_long      = $this->language->get('day_long');
         
         $month_short   = $this->language->get('month_short');
         $month_long    = $this->language->get('month_long');
         
         $date_format_short   = $this->language->get('date_format_short');
         $date_format_long    = $this->language->get('date_format_long');
         
         $day_int    = date('N', $timedate); // 1-7
         $month_int  = date('n', $timedate); // 1-12
         
         if($format == 'dfs') {
            $data = str_replace('%2', $month_short[$month_int], date($date_format_short, $timedate));
         } elseif ($format == 'dfl') {
            $data = str_replace('%1', $month_long[$month_int], date($date_format_long, $timedate));
         } elseif ($format == 'dtf') {
            $data = str_replace('%1', $month_long[$month_int], date($date_time_format, $timedate));
         } else {
            $data = str_replace('%1', $month_long[$month_int], date($date_format, $timedate));
            $data = str_replace('%2', $month_short[$month_int], $data);
            $data = str_replace('%3', $day_long[$month_int], $data);
            $data = str_replace('%4', $day_short[$month_int], $data);
         }
      } else {
         if ($format == 'dtf') {
            $data = date($date_time_format, $timedate);
         } else {
            $data = date($date_format, $timedate);
         }
      }
      
      return $data;
   }
   
   public function getGravatar($email, $width=45, $height=0) {
		$this->load->model('blog/setting');
		$gravEmail		= md5(strtolower( trim($email) ));
      
      if (!$height) {
         $height = $width;
      }
		
		$url = $this->config->get('config_url') . 'image/data/avatar.jpg'; // default image
		
		if (isset($_SERVER['HTTPS']) && (($_SERVER['HTTPS'] == 'on') || ($_SERVER['HTTPS'] == '1'))) { $http = 'https://secure.'; } else { $http = 'http://www.'; }
		$gravCache		= $this->cache->get('blog_gravatar.' . $gravEmail . '.' . date('m'));
		if (!$gravCache) {
			$gravCheck		= $http . 'gravatar.com/avatar/' . $gravEmail . '?d=404'; // Gravatar API change, return 404 http code if mail not available
			
			$curl = curl_init();
         curl_setopt($curl, CURLOPT_URL, $gravCheck);
         curl_setopt($curl, CURLOPT_RETURNTRANSFER, true);
         curl_exec($curl);
         $response = curl_getinfo($curl, CURLINFO_HTTP_CODE);
         curl_close($curl);
			
			if ($response == 200){ // only two possibilities: 200 or 404
				$url = $http . 'gravatar.com/avatar/' . $gravEmail. '?s=' . $width;
			}
			$this->cache->set('blog_gravatar.' . $gravEmail . '.' . date('m'), $response);
			
		} elseif ($gravCache == 200) {
			$url = $http . 'gravatar.com/avatar/' . $gravEmail. '?s=' . $width;
		}

		$gravatar	= '<img src="' . $url . '" alt="Avatar" width="' . $width . 'px" height="' . $height . 'px" class="avatar" />';
		
		return $gravatar;
	}
   
   public function truncate($text, $length = 1000, $ending = '...', $exact = false, $considerHtml = true) {
      if ($considerHtml) {
         if (strlen(preg_replace('/<.*?>/', '', $text)) <= $length) {
            return $text;
         }
         preg_match_all('/(<.+?>)?([^<>]*)/s', $text, $lines, PREG_SET_ORDER);
         $total_length = strlen($ending);
         $open_tags = array();
         $truncate = '';
         foreach ($lines as $line_matchings) {
            if (!empty($line_matchings[1])) {
               if (preg_match('/^<(\s*.+?\/\s*|\s*(img|br|input|hr|area|base|basefont|col|frame|isindex|link|meta|param)(\s.+?)?)>$/is', $line_matchings[1])) {
               } else if (preg_match('/^<\s*\/([^\s]+?)\s*>$/s', $line_matchings[1], $tag_matchings)) {
                  $pos = array_search($tag_matchings[1], $open_tags);
                  if ($pos !== false) {
                  unset($open_tags[$pos]);
                  }
               } else if (preg_match('/^<\s*([^\s>!]+).*?>$/s', $line_matchings[1], $tag_matchings)) {
                  array_unshift($open_tags, strtolower($tag_matchings[1]));
               }
               $truncate .= $line_matchings[1];
            }
            $content_length = strlen(preg_replace('/&[0-9a-z]{2,8};|&#[0-9]{1,7};|[0-9a-f]{1,6};/i', ' ', $line_matchings[2]));
            if ($total_length+$content_length> $length) {
               $left = $length - $total_length;
               $entities_length = 0;
               if (preg_match_all('/&[0-9a-z]{2,8};|&#[0-9]{1,7};|[0-9a-f]{1,6};/i', $line_matchings[2], $entities, PREG_OFFSET_CAPTURE)) {
                  foreach ($entities[0] as $entity) {
                     if ($entity[1]+1-$entities_length <= $left) {
                        $left--;
                        $entities_length += strlen($entity[0]);
                     } else {
                        break;
                     }
                  }
               }
               $truncate .= substr($line_matchings[2], 0, $left+$entities_length);
               break;
            } else {
               $truncate .= $line_matchings[2];
               $total_length += $content_length;
            }
            if($total_length>= $length) {
               break;
            }
         }
      } else {
         if (strlen($text) <= $length) {
            return $text;
         } else {
            $truncate = substr($text, 0, $length - strlen($ending));
         }
      }
      if (!$exact) {
         $spacepos = strrpos($truncate, ' ');
         if (isset($spacepos)) {
            $truncate = substr($truncate, 0, $spacepos);
         }
      }
      $truncate .= $ending;
      if($considerHtml) {
         foreach ($open_tags as $tag) {
            $truncate .= '</' . $tag . '>';
         }
      }
      return $truncate;
   }
}
?>