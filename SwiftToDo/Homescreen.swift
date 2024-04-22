import SwiftUI

struct TaskListView: View {
    @State private var taskList = [Task]()
    @State private var taskNameToAdd: String = ""
    @State private var taskNameAlert: Bool = false
    
    func createNewTask(){
        if(taskNameToAdd == ""){
            return taskNameAlert = true
        }
        let newTask = Task(
            taskName: taskNameToAdd,
            isCompleted: false
        )
        taskList.append(newTask)
        taskNameToAdd = ""
    }
    
    func completeTask(taskID: UUID){
        guard let selectedTask = taskList.firstIndex(where: {$0.id == taskID}) else { return }
        taskList.remove(at: selectedTask)
    }
    
    func clearAllTasks(){
        taskList = []
    }
    
    var body: some View {
        VStack {
            
            Text("Swift To-Do")
                .font(.largeTitle.monospaced())
            
            if taskList.isEmpty {
                Text("No tasks yet.")
                    .padding()
                    .font(.headline.monospaced())
                
                Spacer()
            }
            
            else{
                ScrollView(showsIndicators: false){
                    ForEach(taskList.indices, id: \.self)
                    {index in
                        HStack{
                            Text("\(taskList[index].taskName)")
                                .font(.title.monospaced())
                            
                            Spacer()
                            
                            Button("", systemImage: "checkmark.bubble.fill")
                            {
                                withAnimation{completeTask(taskID: taskList[index].id)}
                            }
                            .font(.title)
                            
                        }
                        .padding()
                        .frame(width: 350, height: 60)
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(.gray, lineWidth: 1))
                    }
                }
                Spacer()
            }
            
            TextField(
                "Task Name...",
                text: $taskNameToAdd)
            .padding()
            .font(.footnote.monospaced())
            .frame(width: 375, height: 40)
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(.gray, lineWidth: 1))
            
            Button("Create New Task", systemImage: "plus.app.fill")
            {
                withAnimation{
                    createNewTask()
                }
            }
            .buttonStyle(.borderedProminent)
            .alert(isPresented: $taskNameAlert){
                Alert(
                    title: Text("Task Name Required"),
                    message: Text("You have to enter a task name for create new task."))
            }
            .font(.headline.monospaced())
            .padding(.top)
            
            Button("Clear All Tasks", systemImage: "trash")
            {
                withAnimation{
                    clearAllTasks()
                }
            }
            .foregroundStyle(.red)
            .buttonStyle(.bordered)
            .font(.headline.monospaced())
            .padding(.bottom)
        }
        .background(.clear)
    }
}

struct Task: Identifiable {
    var id = UUID()
    var taskName: String
    var isCompleted: Bool
}

struct TaskListView_Previews: PreviewProvider {
    static var previews: some View {
        TaskListView()
    }
}
