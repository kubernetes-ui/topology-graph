Kubernetes Topology Graph
=========================

Provides a simple force directed topology graph for kubernetes items.

#### Disclaimer
This is an early implementation and is subject to change.

![Screenshot](https://raw.github.com/kubernetes-ui/topology-graph/master/scratch/screenshot.png)

Getting Started
---------------

The kubernetes describer is provided in the kubernetes-object-describer bower package.

To get the kubernetes-topology-graph bower component in another project, run:

```
bower install kubernetes-topology-graph --save
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

Include the JS and CSS files, after angularjs and d3:

```xml
<script src="bower_components/angular/angular.js"></script>
<script src="bower_components/d3/d3.js"></script>
<script src="bower_components/kubernetes-topology-graph/dist/topology-graph.js"></script>
<link rel="stylesheet" href="bower_components/kubernetes-topology-graph/dist/topology-graph.css" />
```

Make sure your angular app / module includes ```kubernetesUI``` as a module dependency.

```
angular.module('exampleApp', ['kubernetesUI'])
```

Define how the svg vertices (nodes) will display:

```xml
    <svg>
      <defs>
        <g id="vertex-Node">
          <circle r="15" stroke="black" fill="white"></circle>
          <text y="6">N</text>
        </g>
        <g id="vertex-Pod">
          <circle r="15" stroke="black" fill="white"></circle>
          <text y="6">P</text>
        </g>
      </defs>
    </svg>
```

Define the following in your controller scope:

```javascript
$scope.my_items = {
    item1: { kind: "Node" },
    item2: { kind: "Pod" }
};

$scope.my_relations = [
    { source: "item2", "target": "item1"}
];

$scope.my_kinds = {
    "Pod": "#vertex-Pod",
    "Node": "#vertex-Node"
};
```

Now include the graph:

```xml
<kubernetes-topology-graph items="my_items" relations="my_relations" kinds="my_kinds">
</kubernetes-topology-graph>
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
values should be xlink hrefs (eg: html ids prefixed with '#'). These will be used to draw
the vertices.

#### relations

An array of javascript objects describing relations between ```items```. Each object should
have the following properties:

 * ```relation.source```: string key of an item in the ```items``` map.
 * ```relation.target```: string key of an item in the ```items``` map.

#### selection
If this is attribute is set, then it represents the item that should be marked as
selected in the topology. When this is set the 'select' scope event will not automatically
select items in the graph. It becomes the responsibility of the caller to watch for the
event, and change the selection.

#### 'select'

This is a scope event that will be emitted when the selection changes. The argument will
be the item (from the ```items``` map) that is being select, or ```null``` if nothing is
selected. You can call ```event.preventDefault()``` during this event to prevent the default
selection behavior.

#### 'render'

This is a scope event that will be emitted when items are rendered as elements. The argument
will be D3 selection of <g> elements that correspond to items. Each item has its data set to
one of the items. The default implementation of this event sets the title from Kubernetes
metadata and tweaks the look of for certain statuses. Use ```event.preventDefault()``` to
prevent this default behavior.

#### force
Optional. A D3 force layout to use instead of creating one by default. The force layout size
will be updated, and layout  will be started as appropriate. Reassigning this field after
the directive has been created, will not affect the graph, but changes to force layout should
work fine.

Styling
-------

Using the ```<defs>``` and CSS you should be able to achieve the look you want. The
directive applies the item *kind* as a class to each vertex. Each edge also gets a class
with the concatenated item *kind* of the *source* and *target*, in that order.

See ```topology-graph.css``` for an example default look and feel, that uses the classes
described above.

Contributing
------------

Git clone this repo and run `grunt serve`. While the server is running, any time changes
are made to the JS or HTML files the build will run automatically.  Before committing any
changes run the `grunt build` task to make sure dist/topology-graph.js has been updated
and include the updated file in your commit.
