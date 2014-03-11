<?php
class ControllerFeedBlogSitemap extends Controller {
	public function index() {
		$this->load->model('blog/setting');
		$blogSetting = $this->model_blog_setting->getSettings();
		$blogHome 		= unserialize($blogSetting['blogHomeDescription']);
		$language_id 	= $this->config->get('config_language_id');
		if ($blogSetting['blogSitemap']) {
			$output  = '<?xml version="1.0" encoding="UTF-8"?>';
			$output .= '<?xml-stylesheet type="text/xsl" href="catalog/controller/feed/echo-sitemap-style.xsl"?>';
			$output .= '<urlset xmlns="http://www.sitemaps.org/schemas/sitemap/0.9" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:schemaLocation="http://www.sitemaps.org/schemas/sitemap/0.9 http://www.sitemaps.org/schemas/sitemap/0.9/sitemap.xsd">';
			$this->load->model('blog/article');
			$this->load->model('blog/category');

			$data = array(
				'article_order'	=> 'dateDesc',
				'start'				=> 0,
				'limit'				=> $blogSetting['sitemapLimit']
			);
			$results = $this->model_blog_article->getArticles($data);

			foreach ($results as $result) {
				$output .= '<url>';
				$output .= '<loc>' . str_replace('&', '&amp;', $this->url->link('blog/article', 'article_id=' . $result['article_id'])) . '</loc>';
				$output .= '<lastmod>' . gmdate('Y-m-d\TH:i:s+00:00', strtotime($result['modified'])) . '</lastmod>';
				$output .= '<changefreq>weekly</changefreq>';
				$output .= '<priority>1.0</priority>';
				$output .= '</url>';   
			}
			
			//$output .= $this->getCategories(0);

			$output .= '</urlset>';

			$this->response->addHeader('Content-Type: application/xml');
			$this->response->setOutput($output);
		}
	}

	protected function getCategories($parent_id, $current_path = '') {
		$output = '';

		$results = $this->model_blog_category->getCategories($parent_id);

		foreach ($results as $result) {
			if (!$current_path) {
				$new_path = $result['category_id'];
			} else {
				$new_path = $current_path . '_' . $result['category_id'];
			}

			$output .= '<url>';
			$output .= '<loc>' . str_replace('&', '&amp;', $this->url->link('blog/category', 'category_id=' . $new_path)) . '</loc>';
			$output .= '<changefreq>weekly</changefreq>';
			$output .= '<priority>0.7</priority>';
			$output .= '</url>';         

			$data = array(
            'article_order'      => 'dateDesc',
            'filter_category_id' => $result['category_id'],
            'start'              => 0,
            'limit'              => 100
         );
         $articles = $this->model_blog_article->getArticles($data);

			foreach ($articles as $article) {
				$output .= '<url>';
				$output .= '<loc>' . str_replace('&', '&amp;', $this->url->link('blog/article', 'category_id=' . $new_path . '&article_id=' . $article['article_id'])) . '</loc>';
				$output .= '<changefreq>weekly</changefreq>';
				$output .= '<priority>1.0</priority>';
				$output .= '</url>';   
			}   

			$output .= $this->getCategories($result['category_id'], $new_path);
		}

		return $output;
	}      
}
?>