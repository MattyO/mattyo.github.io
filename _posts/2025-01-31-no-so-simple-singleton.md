---
layout: default
title:  "A Not So Simple Singleton"

---

At the core of Python's implementation lies an neat characteristic that you can leverage to create singletons. While singletons can serve as an alternative to dependency injection across long chains of functions, they come with both benefits and potential pitfalls. Let's explore this pattern in detail.

## What is a Singleton?

The traditional singleton pattern defines a class that returns the same object instance no matter how many times you instantiate it. To illustrate this, consider the following:

- With regular classes: `id(RandomClass()) != id(RandomClass())`
- With singleton classes: `id(SingletonClass()) == id(SingletonClass())`

The `id()` function returns an object's memory address, which is unique to each object in Python. With singletons, since you're always working with the same object, modifying properties on any instance affects all references to that singleton:

```python
s1 = SingletonClass()
s1.some_attribute = 1
s2 = SingletonClass()
s2.some_attribute = 2

print(s1.some_attribute)  # Will print 2
```

This behavior occurs because `s1` and `s2` point to the same object in memory.

## The Python Module Singleton Trick

The implementation is surprisingly simple, leveraging two key characteristics of Python:

1. All modules in Python are singletons
2. Any attribute attached to a module inherits this singleton behavior

Let's look at a practical example using the `requests` library's Session object:

```python

# client.py
import requests

session = requests.Session()
```

That's it! Now you can import and use this session across your application:

```python
import client

client.session.cookies.update({'foo': 'bar'})
```

If you import `client` in another file, `client.session` will be the same object, maintaining state (like cookies) across your application.

## Understanding the Module System

To grasp why this works, let's dive deep into Python's module system. The key insight is that Python treats everything as an object - not just the obvious things like integers or class instances, but also functions, classes, and even modules themselves.

### The Object Nature of Python

Consider this example:
```python
x = 42                  # Integer object
def my_func(): pass    # Function object
class MyClass: pass    # Class object
import os              # Module object
```

Each of these lines creates or references an object in Python's memory. This consistent object-oriented approach extends to the module system itself.

### The Module Loading Process

When Python imports a module, it follows a sophisticated process that explains why our singleton pattern works. Let's break it down with an example:

```python
# example.py
x = 1
def hello():
    print("Hello")
class Person:
    pass
```

When another file executes `import example`, Python:

1. Checks if the module is already in its cache (`sys.modules`)
2. If not found, creates a new module object in memory
3. Executes the file line by line
4. Converts each line into module attributes

Internally, it's similar to this process:
```python
# What Python does behind the scenes
module = type('example', (), {})  # Create empty module object
module.x = 1                      # Assign variable as attribute
module.hello = function_object    # Assign function as attribute
module.Person = class_object      # Assign class as attribute
```

### Module Caching: The Key to Singletons

The first time you import a module, Python executes all the code in that module. For subsequent imports, Python returns the cached module instead of re-executing the code:

```python
# First import in any file
import example  # Python executes example.py

# Second import in another file
import example  # Python returns cached module from sys.modules
```

You can actually inspect this cache:
```python
import sys
print(sys.modules['example'])  # Shows your cached module
```

### Import Variations and Their Impact

Python provides two main ways to import, and their differences are crucial for understanding singleton behavior:

```python
# Method 1: Direct module import
import example
example.hello()  # Uses the module object directly

# Method 2: From import
from example import hello
hello()  # Creates a local reference to the function
```

These approaches can lead to different behaviors with singletons:
```python
# File 1
import example
example.x = 2  # Changes the module attribute

# File 2
from example import x
x = 2  # Only changes local reference, not module attribute!
```

### Global State and Module-Level Variables

The `globals()` dictionary in Python contains all module-level names, which explains why module-level variables become natural singletons:

## Potential Pitfalls

### Initialization Timing
Since module variables are set during first import, timing can be unpredictable in complex applications. This can lead to initialization order dependencies.

### Reset Challenges
Modules are read only once, making it difficult to reset singleton states. This becomes particularly relevant in testing scenarios or when configuration changes require re-initialization.

### Module Local Reference Issues
The difference between `import module` and `from module import object` can lead to surprising behavior. The latter creates a local reference that can diverge from the original module attribute if modified locally.

## Best Practices (_debatable?_)

To mitigate these challenges, consider the following approaches:

1) Use a function to access your singleton:

```python
# client.py
import requests

_session = requests.Session()

def get_session():
    return _session
```

2) Implement a wrapper class for better control:

```python
# singleton_wrapper.py
class Wrapper:
    def __init__(self, wrapped_instance):
        self.wrapped_instance = wrapped_instance

    def __getattr__(self, attr):
        return getattr(self.wrapped_instance, attr)

    def get_instance_prop(self, attr_name):
        return getattr(self.wrapped_instance, attr_name)

    def reset_instance(self, new_instance):
        self.wrapped_instance = new_instance

    def get_instance(self):
        return self.wrapped_instance

#client.py
import singleton_wrapper
import requests

client = singleton_wrapper.Wrapper(requests.Session())

def request_session():
    return client
```

This wrapper approach provides several benefits:
- Controlled state and reset capabilities,
- a wrapper is a better understood interface(a class vs python module internals)
- Lazy instantiation options to better control when thing get created
- Clean interface for managing private objects
- Transparent method passthrough

Usage remains straightforward:

```python
from client import request_session

request_session().cookies.update({'test': 'cookie'})

```

Thats it! Thanks for reading....

Checkout the full set of example files on github [MattyO/python-singleton-example](https://github.com/MattyO/python-singleton-example)

Your Friend,

-Matty
