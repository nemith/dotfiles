import terminatorlib.plugin as plugin


AVAILABLE = ['FBTasksURLHandler', 'FBPhabricatorURLHandler']

class FBTasksURLHandler(plugin.URLHandler):
    capabilities = ['url_handler']
    handler_name = 'fb_tasks'
    match = '\\b([Tt][0-9]+)\\b'
    nameopen = "Open Task"
    namecopy = "Copy Task"

    def callback(self, url):
        url = url[1:]
        return('https://our.intern.facebook.com/intern/tasks/?t=%s' % url)


class FBPhabricatorURLHandler(plugin.URLHandler):
    capabilities = ['url_handler']
    handler_name = 'fb_phabricator'
    match = '\\b([DdPp][0-9]+)\\b'
    nameopen = "Open Phabricator Link"
    namecopy = "Copy Phabricator Link"

    def callback(self, url):
        return('https://phabricator.fb.com/%s' % url.upper())
