import unittest
from hello_world import app

class IndexTestCase(unittest.TestCase):

    def setUp(self):
        app.config['TESTING'] = True
        self.app = app.test_client()

    def tearDown(self):
        pass

    def test_index(self):
        rv = self.app.get('/')
        assert rv.data

if __name__ == '__main__':
    unittest.main()
