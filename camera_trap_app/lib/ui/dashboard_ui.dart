import 'package:camera_trap_app/ui/projects_details_ui.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import '../models/db_model.dart';
import '../services/helper_service.dart';
import 'package:drift/drift.dart';

class ProjectDashboard extends StatefulWidget {
  const ProjectDashboard({super.key});

  @override
  State<ProjectDashboard> createState() => _ProjectDashboardState();
}

class _ProjectDashboardState extends State<ProjectDashboard> {
  final DriftService _dbService = DriftService();
  final TextEditingController _nameController = TextEditingController();
  List<ProjectFolder> _projects = [];

  @override
  void initState() {
    super.initState();
    _refreshProjects();
  }

  void _refreshProjects() async {
    final data = await _dbService.getAllProjects();
    setState(() => _projects = data);
  }

  void _showEditFolderDialog(ProjectFolder project) {
  final controller = TextEditingController(text: project.name);
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: const Text('Rename Project Folder'),
      content: TextField(
        controller: controller,
        decoration: const InputDecoration(labelText: 'Project Name'),
      ),
      actions: [
        TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel')),
        ElevatedButton(
          onPressed: () async {
            if (controller.text.trim().isNotEmpty) {
              await _dbService.updateProjectFolder(
                project.id,
                ProjectFoldersCompanion(name: Value(controller.text.trim())),
              );
              Navigator.pop(context);
              _refreshProjects(); // Call your existing screen reload function
            }
          },
          child: const Text('Save'),
        )
      ],
    ),
  );
}

void _showDeleteFolderConfirmation(ProjectFolder project) {
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: const Text('Delete Project Folder?'),
      content: Text('This will permanently delete "${project.name}" and all camera trap deployments inside it. This action cannot be reversed.'),
      actions: [
        TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel')),
        ElevatedButton(
          style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
          onPressed: () async {
            await _dbService.deleteProjectFolder(project.id);
            Navigator.pop(context);
            _refreshProjects();
          },
          child: const Text('Delete Everywhere', style: TextStyle(color: Colors.white)),
        )
      ],
    ),
  );
}

  void _showCreateDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('New Project Folder'),
        content: TextField(
          controller: _nameController,
          decoration: const InputDecoration(hintText: 'Project Name'),
          autofocus: true,
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel')),
          ElevatedButton(
            onPressed: () async {
              if (_nameController.text.trim().isEmpty) return;
              final proj = ProjectFoldersCompanion.insert(
                uuid: const Uuid().v4(),
                name: _nameController.text.trim(),
                dateCreated: DateTime.now(),
              );
              await _dbService.saveProject(proj);
              _nameController.clear();
              Navigator.pop(context);
              _refreshProjects();
            },
            child: const Text('Create'),
          )
        ],
      ),
    );
  }

  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Camera Trap Folders')),
      body: _projects.isEmpty
          ? const Center(child: Text('No project directories established yet.'))
          : ListView.builder(
  padding: const EdgeInsets.only(top: 8, bottom: 80), // Prevent FAB from hiding the last item
  itemCount: _projects.length,
  itemBuilder: (context, itemIndex) {
    final project = _projects[itemIndex];
    return Card(
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ProjectDetailScreen(project: project),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: ListTile(
  leading: const Icon(Icons.folder, size: 40, color: Colors.amber),
  title: Text(project.name, style: const TextStyle(fontWeight: FontWeight.bold)),
  subtitle: Text('Created: ${project.dateCreated.toString().split(' ')[0]}'),
  onTap: () => Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => ProjectDetailScreen(project: project)),
  ),
  // NEW MANAGE OPTIONS DROPDOWN
  trailing: PopupMenuButton<String>(
    onSelected: (action) {
      if (action == 'edit') {
        _showEditFolderDialog(project);
      } else if (action == 'delete') {
        _showDeleteFolderConfirmation(project);
      }
    },
    itemBuilder: (context) => [
      const PopupMenuItem(value: 'edit', child: Row(children: [Icon(Icons.edit, size: 18), SizedBox(width: 8), Text('Rename')])),
      const PopupMenuItem(value: 'delete', child: Row(children: [Icon(Icons.delete, color: Colors.red, size: 18), SizedBox(width: 8), Text('Delete', style: TextStyle(color: Colors.red))])),
    ],
  ),
),
        ),
      ),
    );
  },
),
      floatingActionButton: FloatingActionButton(
        onPressed: _showCreateDialog,
        child: const Icon(Icons.create_new_folder),
      ),
    );
  }
}