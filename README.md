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
<script src="bower_components/kubernetes-topology-graph/dist/topology-graph.js"></script
<link rel="stylesheet" href="bower_components/kubernetes-topology-graph/dist/topology-graph.css" />
```

Make sure your angular app / module includes ```kubernetesUI``` as a module dependency.

```
angular.module('exampleApp', ['kubernetesUI'])
```

Define how the svg vertices (nodes) will display:

```xml
    <svg class="kube-topology">
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
    { source: "item2", "target": "item1"
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
