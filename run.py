import urllib.request

base_url = "https://www.printabulls.com/wp-content/uploads/2023/09/Printable-Number-{}-.pdf"

for i in range(1, 16):
    url = base_url.format(i)
    filename = f"Number-{i}.pdf"
    try:
        urllib.request.urlretrieve(url, filename)
        print(f"Downloaded {filename}")
    except Exception as e:
        print(f"Failed to download {filename}: {e}")
