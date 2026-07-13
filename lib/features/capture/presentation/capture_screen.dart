import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../app/providers.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/widgets/liquid_glass.dart';
import '../../../domain/entities/models.dart';
import '../../../services/ai/ai_models.dart';

class CaptureScreen extends ConsumerStatefulWidget {
  const CaptureScreen({super.key, this.initialText});
  final String? initialText;
  @override
  ConsumerState<CaptureScreen> createState() => _CaptureScreenState();
}

class _CaptureScreenState extends ConsumerState<CaptureScreen> {
  late final TextEditingController text = TextEditingController(
    text: widget.initialText,
  );
  bool sensitive = false, processing = true, saving = false;
  @override
  void initState() {
    super.initState();
    _consumeShare();
  }

  Future<void> _consumeShare() async {
    if (text.text.isNotEmpty) return;
    try {
      final value = await const MethodChannel(
        'mindvault/share',
      ).invokeMethod<String>('consumeSharedText');
      if (value != null && mounted) text.text = value;
    } on PlatformException {
      /* Android share is optional. */
    }
  }

  Future<void> _save() async {
    final body = text.text.trim();
    if (body.isEmpty) return;
    setState(() => saving = true);
    final analysis = processing && !sensitive
        ? await ref
              .read(aiServiceProvider)
              .analyzeMemory(MemoryAnalysisRequest(body))
        : const MemoryAnalysis(
            title: 'Unprocessed thought',
            summary: 'Saved locally for later review.',
          );
    await ref
        .read(memoryRepositoryProvider)
        .save(
          Memory(
            id: DateTime.now().microsecondsSinceEpoch.toString(),
            title: analysis.title,
            body: body,
            summary: analysis.summary,
            createdAt: DateTime.now(),
            includeInAi: processing && !sensitive,
          ),
        );
    if (mounted) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Saved locally')));
      context.go('/memories');
    }
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
      backgroundColor: Colors.transparent,
      title: const Text('New brain dump'),
      actions: [
        TextButton(
          onPressed: saving ? null : _save,
          child: Text(saving ? 'Saving…' : 'Save'),
        ),
      ],
    ),
    body: SafeArea(
      child: ListView(
        padding: const EdgeInsets.fromLTRB(20, 10, 20, 120),
        children: [
          TextField(
            controller: text,
            autofocus: true,
            maxLines: 14,
            minLines: 8,
            style: const TextStyle(fontSize: 20, height: 1.55),
            decoration: const InputDecoration(
              hintText: 'Pour out anything. Ideas, decisions, questions…',
              filled: false,
              border: InputBorder.none,
            ),
          ),
          const SizedBox(height: 12),
          Wrap(
            spacing: 8,
            children: [
              ActionChip(
                avatar: const Icon(Icons.mic, size: 18),
                label: const Text('Voice'),
                onPressed: () {},
              ),
              ActionChip(
                avatar: const Icon(Icons.image, size: 18),
                label: const Text('Image'),
                onPressed: () {},
              ),
              ActionChip(
                avatar: const Icon(Icons.attach_file, size: 18),
                label: const Text('File'),
                onPressed: () {},
              ),
            ],
          ),
          const SizedBox(height: 20),
          LiquidGlassCard(
            child: Column(
              children: [
                SwitchListTile(
                  contentPadding: EdgeInsets.zero,
                  title: const Text('Sensitive content'),
                  subtitle: const Text(
                    'Hold locally until you explicitly approve AI processing.',
                  ),
                  value: sensitive,
                  onChanged: (v) => setState(() {
                    sensitive = v;
                    if (v) processing = false;
                  }),
                ),
                const Divider(),
                SwitchListTile(
                  contentPadding: EdgeInsets.zero,
                  title: const Text('Process with Gemini'),
                  subtitle: Text(
                    sensitive
                        ? 'Disabled by sensitive-content safeguard'
                        : 'Generate title, summary, tasks, and connections',
                  ),
                  value: processing,
                  onChanged: sensitive
                      ? null
                      : (v) => setState(() => processing = v),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          const Row(
            children: [
              Icon(
                Icons.cloud_off_rounded,
                size: 17,
                color: VaultColors.success,
              ),
              SizedBox(width: 8),
              Text(
                'Auto-saved locally · private by default',
                style: TextStyle(color: VaultColors.muted),
              ),
            ],
          ),
        ],
      ),
    ),
  );
}
