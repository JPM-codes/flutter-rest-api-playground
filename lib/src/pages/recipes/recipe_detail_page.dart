import 'package:flutter/material.dart';
import 'package:rest_api_playground/src/pages/model/recipe_model.dart';

class RecipeDetailPage extends StatefulWidget {
  const RecipeDetailPage({super.key, required this.recipe});

  final RecipeModel recipe;

  @override
  State<RecipeDetailPage> createState() => _RecipeDetailPageState();
}

class _RecipeDetailPageState extends State<RecipeDetailPage> {
  @override
  Widget build(BuildContext context) {
    // Pega a cor de fundo padrão do tema para suportar Light/Dark mode perfeitamente
    final backgroundColor = Theme.of(context).scaffoldBackgroundColor;

    return Scaffold(
      backgroundColor: backgroundColor,
      body: CustomScrollView(
        slivers: [
          // 1. Cabeçalho retrátil com a imagem da receita
          SliverAppBar(
            expandedHeight: 320,
            pinned: true,
            stretch: true,
            backgroundColor: Theme.of(context).colorScheme.primary,
            elevation: 0,
            iconTheme: const IconThemeData(color: Colors.white), // Garante que o botão de voltar seja visível
            flexibleSpace: FlexibleSpaceBar(
              stretchModes: const [StretchMode.zoomBackground],
              background: Stack(
                fit: StackFit.expand,
                children: [
                  Image.network(
                    widget.recipe.image,
                    fit: BoxFit.cover,
                  ),
                  // Gradiente no topo para o botão de voltar não sumir em imagens claras
                  const DecoratedBox(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.center,
                        colors: [Colors.black54, Colors.transparent],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            // Borda arredondada super charmosa na transição da imagem para o conteúdo
            bottom: PreferredSize(
              preferredSize: const Size.fromHeight(30),
              child: Container(
                height: 30,
                decoration: BoxDecoration(
                  color: backgroundColor,
                  borderRadius: const BorderRadius.vertical(top: Radius.circular(32)),
                ),
              ),
            ),
          ),

          // 2. Conteúdo rolável da página
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Título principal
                  Text(
                    widget.recipe.name,
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).colorScheme.onSurface,
                        ),
                  ),
                  const SizedBox(height: 24),

                  // 3. Informações Rápidas (Badges de Calorias, Dificuldade e Porções)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _buildInfoBadge(
                        context,
                        icon: Icons.local_fire_department_rounded,
                        label: '${widget.recipe.caloriesPerServing} kcal',
                        color: Colors.orange,
                      ),
                      _buildInfoBadge(
                        context,
                        icon: Icons.bar_chart_rounded,
                        label: widget.recipe.difficulty,
                        color: Colors.blue,
                      ),
                      _buildInfoBadge(
                        context,
                        icon: Icons.restaurant_rounded,
                        label: '${widget.recipe.servings} Porções',
                        color: Colors.green,
                      ),
                    ],
                  ),
                  const SizedBox(height: 32),

                  // 4. Seção de Ingredientes
                  Text(
                    'Ingredientes',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  const SizedBox(height: 12),
                  ListView.separated(
                    padding: EdgeInsets.zero,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: widget.recipe.ingredients.length,
                    separatorBuilder: (context, index) => Divider(color: Colors.grey.withOpacity(0.2)),
                    itemBuilder: (context, index) {
                      return ListTile(
                        contentPadding: EdgeInsets.zero,
                        leading: const Icon(Icons.check_circle, color: Colors.green, size: 24),
                        title: Text(
                          widget.recipe.ingredients[index],
                          style: const TextStyle(fontSize: 16),
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 32),

                  // 5. Seção de Instruções
                  Text(
                    'Instruções',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  const SizedBox(height: 16),
                  ListView.separated(
                    padding: EdgeInsets.zero,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: widget.recipe.instructions.length,
                    separatorBuilder: (context, index) => const SizedBox(height: 20),
                    itemBuilder: (context, index) {
                      return Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Círculo numerado para cada passo
                          CircleAvatar(
                            radius: 14,
                            backgroundColor: Theme.of(context).colorScheme.primary,
                            child: Text(
                              '${index + 1}',
                              style: const TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          const SizedBox(width: 16),
                          // Texto da instrução
                          Expanded(
                            child: Text(
                              widget.recipe.instructions[index],
                              style: const TextStyle(height: 1.5, fontSize: 16),
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                  const SizedBox(height: 48), // Respiro no final da página
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Widget auxiliar para criar os "chips" de categorias bonitinhos
  Widget _buildInfoBadge(BuildContext context, {required IconData icon, required String label, required Color color}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: color, size: 20),
          const SizedBox(width: 6),
          Text(
            label,
            style: TextStyle(
              color: color,
              fontWeight: FontWeight.bold,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }
}