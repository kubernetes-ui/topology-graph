Kubernetes Topology Graph
=========================

Provides a simple force directed topology graph for kubernetes items.

#### Disclaimer
This is an early implementation and is subject to change.

![Screenshot](https://raw.github.com/stefwalter/topology-graph/master/screenshot.png)

Getting Started
---------------

The kubernetes describer is provided in the kubernetes-object-describer bower package.

To use the kubernetes-topology-graph bower component in another project, run:

```
bower install kubernetes-topology-graph --save
```

To use the topology graph directive include the ```dist/topology-graph.js'. Make sure your
angular app / module includes ```kubernetesUI``` as a module dependency.

```
angular.module('exampleApp', ['kubernetesUI'])
```

To see a simple running example git clone this repo and run

```
npm install
grunt depends
firefox index.html
```

This will install any required dependencies necessary to run the ```index.html``` demo.
Usage
-----

You need to have the following in your scope. Each is discussed in details below.

 * ```items``` an object map of kubernetes items to display
 * ```relations``` an array of relations between those items
 * ```kinds``` optional, a map with keys that are kubernetes *kind* strings

To use the element:

```
<kubernetes-topology-graph items="my_items" relations="my_relations" kinds="my_kinds">
</kubernetes-topology-graph>
```

Include the CSS file:

```
<link rel="stylesheet" href="topology-graph.css">
```

Documentation
-------------

#### items

A javascript plain object containing kubernetes items as property values. The keys
of this object are used in the ```relations``` attribute. The items should have a
```item.kind``` attribute, as well as the usual ```item.metadata``` and so on.

#### kinds

A javascript plain object with kubernetes kinds as keys (ie: *Pod*, *Service* ...). Only
items with an ```item.kind``` that is a key in this object will be displayed. The
values should be strings. These strings will be placed inside each item's circle in the
topology view. Usually the strings are characters in a special icon font. The values may
also be blank strings.

#### relations

An array of javascript objects describing relations between ```items```. Each object should
have the following properties:

 * ```relation.source```: string key of an item in the ```items``` map.
 * ```relation.target```: string key of an item in the ```items``` map.
 * ```relation.kinds```: string concatenation of the two kubernetes kinds involved
   (eg: ```PodService```), in source -> target order.

#### 'selected'

This is a scope event that will be emitted when the selection changes. The argument will
be the item (from the ```items``` map) that was selected, or ```null``` if nothing is
selected.

Contributing
------------

Git clone this repo and run `grunt serve`. While the server is running, any time changes
are made to the JS or HTML files the build will run automatically.  Before committing any
changes run the `grunt build` task to make sure dist/topology-graph.js has been updated
and include the updated file in your commit.
