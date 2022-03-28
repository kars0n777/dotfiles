import dracula.draw

# Load existing settings made via :set
config.load_autoconfig()

dracula.draw.blood(c, {
    'spacing': {
        'vertical': 6,
        'horizontal': 8
    }
})

c.url.searchengines = {
        'DEFAULT':  'https://searx.be/search?q=en&q={}',
}

c.url.start_pages = ['https://searx.be/'] 
            
