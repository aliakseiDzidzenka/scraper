class ScrapOnliner 

	attr_accessor :images_src, :headers, :descriptions, :url, :scraper

	def initialize(scraper)
		@url = 'https://www.onliner.by'
		@images_src = []
		@headers = []
		@descriptions = []
		@scraper = scraper
	end

	def scroll(times = 1000, scroll = 100)
		if times.to_i.is_a?(Integer) == false || scroll.to_i.is_a?(Integer) == false
			puts "give Integer arguments"
			return
		else
			times.times { scraper.execute_script("window.scrollBy(0,#{scroll})") }
		end
	end

	def make_all_elements_visible(tag_name, display_type = 'block')
		scraper.execute_script("x = document.getElementsByTagName('#{tag_name}'); for(i=0;i<x.length;i++) x[i].setAttribute('style', 'display: #{display_type}');")
	end

	def scrap_images_src
		check_visit
		scroll
		scraper.find_all('figure a img').each { |e| images_src.push(e['src']) if /.+news.+.[jpeg|png|jpg]/.match(e['src'])}
	end

	def scrap_headers
		check_visit
		scraper.find_all('.b-main-page-grid-4 article h2 a, h3 a').each { |h| headers.push(h.text) if /.+forum.+/.match(h['href']) == nil }
	end

	def scrap_descriptions
		check_visit
		make_all_elements_visible('p')
		scraper.find_all('.b-main-page-grid-4 p').each { |par| descriptions.push(par.text) }
		3.times{ descriptions.delete_at(descriptions.length - 1) }
	end

	private

	def check_visit
		if scraper.current_host.to_s != url.to_s
			scraper.visit(url)
		end
	end

end

