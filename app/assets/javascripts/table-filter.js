angular.module("table.extensions", ["table.filter"]);
angular.module('table.filter', [])

.controller('TableFilterController', ['$scope', '$attrs', '$parse', '$interpolate', function ($scope, $attrs, $parse, $interpolate) {
  var self = this;

  this.init = function() {
  }

  $scope.selectFilter = function() {
    $scope.$parent.incidentType    = $scope.option.value;
  };

  $scope.setSearch = function() {
    $scope.$parent.searchText       = $scope.searchText;
  };

  $scope.search = function(){
    $scope.$parent.currentPage      = 1
    $scope.$parent.loadIncidents()
  }

}])

.constant('tableFilterConfig', {
})

.directive('tableFilter', ['$parse', 'tableFilterConfig', function($parse, config) {
  return {
    restrict: 'EA',
    scope: {
      incidentTypes: '=',
      incidentType: '=',
    },
    controller: 'TableFilterController',
    templateUrl: '/assets/tables/filter.html',
    replace: true,
    link: function(scope, element, attrs, tableFilterCtrl) {
      tableFilterCtrl.init();
    }
  }
}]);