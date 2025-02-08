class MapTasks {
  var tasks = [];
  static MapTasks instancia = MapTasks();

  void add_to_mapa(Map<String, dynamic>dados){
    tasks.add(dados);
  }

  dynamic get_mapa(){
    return tasks;
  }

  dynamic retorne_elemento(int index, String key){
    return tasks[index][key];
  }
  
  void remove_elemento(int index){
    tasks.removeAt(index);
  }
}