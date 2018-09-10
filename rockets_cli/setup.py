from setuptools import setup

setup(
    name='Rockets',
    version='1.0',
    py_modules=['rockets'],
    install_requires=[
        'click',
        'requests',
    ],
    entry_points='''
        [console_scripts]
        rockets=rockets:rockets
    ''',
)
