import re
import terminatorlib.plugin as plugin

AVAILABLE = [
    'FBTasksURLHandler',
    'FBPhabricatorURLHandler',
    'FBSEVURLHandler',
]

INTERN = "https://our.intern.facebook.com/intern/"


class FBTasksURLHandler(plugin.URLHandler):
    capabilities = ['url_handler']
    handler_name = 'fb_tasks'
    match = r'\b([Tt][0-9]+)\b'
    nameopen = "Open Task"
    namecopy = "Copy Task"

    def callback(self, url):
        url = url[1:]
        return(INTERN + 'tasks/?t=%s' % url)


class FBPhabricatorURLHandler(plugin.URLHandler):
    capabilities = ['url_handler']
    handler_name = 'fb_phabricator'
    match = r'\b([DdPp][0-9]+)\b'
    nameopen = "Open Phabricator Link"
    namecopy = "Copy Phabricator Link"

    def callback(self, url):
        return('https://phabricator.fb.com/%s' % url.upper())

class FBSEVURLHandler(plugin.URLHandler):
    capabilities = ['url_handler']
    handler_name = 'fb_sev'
    match = r'\b[sS]([0-9]+)\b'
    nameopen = "Open SEV"
    namecopy = "Copy SEV Link"

    def callback(self, url):
        m = re.match(r'[sS]([0-9]+)', url)
        return INTERN + 'sevmanager/view/s/%s' % m.group(1)
