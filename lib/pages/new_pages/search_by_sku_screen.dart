import 'package:flutter/material.dart';
import '/backend/api_requests/api_calls.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import 'dart:convert';

class QuickSkuOrderPage extends StatefulWidget {
  const QuickSkuOrderPage({Key? key}) : super(key: key);

  @override
  State<QuickSkuOrderPage> createState() => _QuickSkuOrderPageState();
}

class _QuickSkuOrderPageState extends State<QuickSkuOrderPage> {
  final TextEditingController _skuController = TextEditingController();
  final FocusNode _skuFocusNode = FocusNode();

  // Fill with your user's recent SKUs
  final List<String> _recentSkus = [
    'SKU0001',
    'SKU0002',
    'SKU0003',
    'SKU0004',
    'SKU0005',
    'SKU0006',
    'SKU0007',
    'SKU0008',
  ];
  String? _searchedSku;
  Map<String, dynamic>? _foundProduct;
  bool _loading = false;
  int _qty = 1;

  void _skuSearch(String sku) async {
    if (sku.trim().isEmpty) return;
    setState(() {
      _loading = true;
      _foundProduct = null;
      _searchedSku = sku.trim();
      _qty = 1;
    });
    try {
      final response = await SearchProductBySkuCall.call(sku: sku.trim());
      if (response.succeeded && response.jsonBody != null) {
        final json = response.jsonBody;
        // WooCommerce products endpoint always returns a list
        if (json is List && json.isNotEmpty) {
          setState(() {
            _foundProduct = json[0];
          });
        } else {
          setState(() {
            _foundProduct = null;
          });
        }
      } else {
        setState(() {
          _foundProduct = null;
        });
      }
    } catch (e) {
      setState(() {
        _foundProduct = null;
      });
    } finally {
      setState(() {
        _loading = false;
      });
    }
  }

  void _onChipTap(String sku) {
    _skuController.text = sku;
    _skuSearch(sku);
  }

  Widget _buildInfoCard() {
    return Container(
      decoration: BoxDecoration(
        color: Color(0xFFE6F3FF),
        borderRadius: BorderRadius.circular(12),
        border: Border(
          left: BorderSide(color: Color(0xFF0072BC), width: 4),
        ),
      ),
      padding: EdgeInsets.all(16),
      margin: EdgeInsets.only(bottom: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  'How to use quick SKU order',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: Color(0xFF0072BC),
                  ),
                ),
              ),
              Icon(Icons.close, color: Color(0xFF0072BC)),
            ],
          ),
          SizedBox(height: 8),
          Text(
            'Enter the product SKU to quickly find and order items. This is perfect for repeat orders when you know the exact product code.',
            style: TextStyle(color: Colors.black, fontSize: 13),
          ),
          SizedBox(height: 12),
          Text(
            'Sample SKUs to try:',
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 13,
              color: Color(0xFF0072BC),
            ),
          ),
          SizedBox(height: 8),
          Wrap(
            spacing: 10,
            children: [
              _buildSampleChip('SKU0001'),
              _buildSampleChip('SKU0002'),
              _buildSampleChip('SKU0002'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSampleChip(String sku) {
    return InkWell(
      onTap: () => _onChipTap(sku),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Color(0xFF0072BC)),
          borderRadius: BorderRadius.circular(20),
        ),
        padding: EdgeInsets.symmetric(horizontal: 14, vertical: 5),
        child: Text(
          sku,
          style:
              TextStyle(color: Color(0xFF0072BC), fontWeight: FontWeight.w600),
        ),
      ),
    );
  }

  Widget _buildSkuSearchBox() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: TextField(
        controller: _skuController,
        focusNode: _skuFocusNode,
        decoration: InputDecoration(
          hintText: "SKU0001",
          fillColor: Color(0xFFF7F8F9),
          filled: true,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(color: Color(0xFFE5E6EA)),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(color: Color(0xFF1076BA)),
          ),
          suffixIcon: IconButton(
            icon: Icon(Icons.search, color: Color(0xFF9C9C9C)),
            onPressed: () {
              FocusScope.of(context).unfocus();
              _skuSearch(_skuController.text);
            },
          ),
          contentPadding: EdgeInsets.symmetric(horizontal: 14, vertical: 16),
        ),
        style: TextStyle(fontSize: 16, color: Color(0xFF888888)),
        onSubmitted: (val) {
          FocusScope.of(context).unfocus();
          _skuSearch(val);
        },
      ),
    );
  }

  Widget _buildProductCard(Map<String, dynamic> product) {
    // Get values from product json (WooCommerce response)
    String name = product['name'] ?? '-';
    String sku = product['sku'] ?? '-';
    String? img = (product['images'] is List && product['images'].isNotEmpty)
        ? product['images'][0]['src']
        : null;
    String price = product['price'] ?? '-';

    return Column(
      children: [
        Text(
          'Product Found',
          style: TextStyle(
              color: Color(0xFF0072BC),
              fontWeight: FontWeight.bold,
              fontSize: 18),
        ),
        SizedBox(height: 16),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: Color(0xFFE5E6EA)),
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                  color: Colors.grey.withOpacity(0.06),
                  blurRadius: 8,
                  offset: Offset(0, 3))
            ],
          ),
          padding: EdgeInsets.all(14),
          margin: EdgeInsets.symmetric(vertical: 6),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // product image
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: img != null
                    ? Image.network(img,
                        width: 60, height: 60, fit: BoxFit.cover)
                    : Container(
                        color: Colors.grey.shade200,
                        width: 60,
                        height: 60,
                        child:
                            Icon(Icons.image_not_supported, color: Colors.grey),
                      ),
              ),
              SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(name,
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 15,
                        )),
                    SizedBox(height: 4),
                    Text('SKU: $sku',
                        style: TextStyle(color: Colors.black87, fontSize: 13)),
                    SizedBox(height: 6),
                    Text(
                      '£$price',
                      style: TextStyle(
                          color: Color(0xFF0072BC),
                          fontSize: 16,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.favorite_border, color: Color(0xFF9C9C9C))),
            ],
          ),
        ),
        SizedBox(height: 12),
        Row(
          children: [
            Text(
              'Qty:',
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 16,
              ),
            ),
            SizedBox(width: 14),
            InkWell(
              onTap: () {
                if (_qty > 1)
                  setState(() {
                    _qty--;
                  });
              },
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Color(0xFFC9CCCF)),
                  shape: BoxShape.circle,
                  color: Color(0xFFF7F8F9),
                ),
                padding: EdgeInsets.all(4),
                child: Icon(Icons.remove, size: 20, color: Color(0xFF9C9C9C)),
              ),
            ),
            SizedBox(width: 8),
            Text(
              '$_qty',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
            SizedBox(width: 8),
            InkWell(
              onTap: () {
                setState(() {
                  _qty++;
                });
              },
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Color(0xFFC9CCCF)),
                  shape: BoxShape.circle,
                  color: Color(0xFFF7F8F9),
                ),
                padding: EdgeInsets.all(4),
                child: Icon(Icons.add, size: 20, color: Color(0xFF1076BA)),
              ),
            ),
          ],
        ),
        SizedBox(height: 14),
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: () {
              // TODO: Add to Cart logic
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Added $_qty x $name to cart!')),
              );
            },
            style: ElevatedButton.styleFrom(
              padding: EdgeInsets.symmetric(vertical: 14),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8)),
              primary: const LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: [Color(0xFF1076BA), Color(0xFF0E87CB)],
              ).createShader(Rect.fromLTWH(0, 0, 200, 50)),
              // This causes warning but is for illustration of gradient
              backgroundColor: const Color(0xFF1076BA),
            ).copyWith(
              foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
            ),
            child: Text(
              'Add to Cart',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildRecents() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Recent SKU",
          style: TextStyle(
            fontWeight: FontWeight.w700,
            color: Color(0xFF343B51),
            fontSize: 16,
          ),
        ),
        SizedBox(height: 10),
        Wrap(
          spacing: 12,
          runSpacing: 10,
          children: _recentSkus
              .map((sku) => GestureDetector(
                    onTap: () {
                      _onChipTap(sku);
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: Color(0xFFF7F8F9),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      padding:
                          EdgeInsets.symmetric(horizontal: 18, vertical: 10),
                      child: Text(sku,
                          style: TextStyle(
                              color: Color(0xFF222B45),
                              fontWeight: FontWeight.w500,
                              fontSize: 15)),
                    ),
                  ))
              .toList(),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: BackButton(color: Color(0xFF343B51)),
        title: Text(
          'Quick SKU Order',
          style: TextStyle(
            color: Color(0xFF343B51),
            fontWeight: FontWeight.w700,
            fontSize: 18,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(16, 10, 16, 16),
        child: Column(
          children: [
            // Info box
            _buildInfoCard(),
            // Search box
            _buildSkuSearchBox(),
            // Loader
            if (_loading)
              Padding(
                padding: EdgeInsets.all(16),
                child: Center(child: CircularProgressIndicator()),
              ),
            // Product card
            if (!_loading && _foundProduct != null)
              Padding(
                padding: EdgeInsets.only(top: 12, bottom: 24),
                child: _buildProductCard(_foundProduct!),
              ),
            // Recents
            SizedBox(height: 12),
            _buildRecents(),
          ],
        ),
      ),
    );
  }
}
